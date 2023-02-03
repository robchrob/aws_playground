data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = [var.ec2_ami_owner]

  filter {
    name   = "name"
    values = [var.ec2_ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ec2_ami_virtualization_filter]
  }
}

