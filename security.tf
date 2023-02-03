resource "aws_security_group" "sandbox-security_group" {
  name   = "allow-ssh"
  vpc_id = aws_vpc.sandbox-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "sandbox-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sandbox-key_pair" {
  key_name   = "ssh_access"
  public_key = tls_private_key.sandbox-key.public_key_openssh
}
