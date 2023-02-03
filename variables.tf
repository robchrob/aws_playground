variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "availability_zone" {
  type    = string
  default = "eu-central-1a"
}

variable "ec2_ami_owner" {
  type    = string
  default = "080406349856"
}

variable "ec2_ami_name_filter" {
  type    = string
  default = "rch-sandbox-image-*"
}

variable "ec2_ami_virtualization_filter" {
  type    = string
  default = "hvm"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_username" {
  type    = string
  default = "arch"
}
