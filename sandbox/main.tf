# configure AWS provider
provider "aws" {
  region = "eu-central-1"
}

# configure remote state storage in S3 bucket
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "rch-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

# create EC2 instance
resource "aws_instance" "server" {
  ami           = "ami-076309742d466ad69"
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  # create security group that allows SSH access
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  subnet_id                   = "subnet-0089f484b8ea43bd7"
  associate_public_ip_address = true
}

# create security group for EC2 instance
resource "aws_security_group" "my-sg" {
  name        = "allow-ssh"
  description = "Allow SSH access"
  vpc_id      = "vpc-0b54ef0b170cbe4e2"

  # allow incoming SSH connections
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4VZwby9Lzj7d06PJdb4NL2HUUtELua9BWRTfPagwCrVRu5fPSIgufOjB8tgARJu0lAttIhuIyjSOow8RmmfBqLiwfZVjmXxPhPc/c2vyGD4BrBQFUJIpC/+yJbusE9XbgDKghTxvOP3Os1whTgddmJKtkwrfUWyWTGqnFolxGlh99oX5ygpYHmBZ7lLQ20Z9wGbnwOCvr1/j2Krn0HIWmqrWFYjnoKuox2xDCzmrDj7AqUue08Nc4JLTQhpezQ+dzI86EnJqsal4WCAOGzITLa/Ia8QccGySQqc/MKsejFje0j8WSmY3h1xZYAv5r0uXA7AqiPIevHtrHqHOArbl1 rch@archlocal"
}
