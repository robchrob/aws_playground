resource "aws_instance" "sandbox-server" {
  ami           = data.aws_ami.latest_ami.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.sandbox-key_pair.key_name

  vpc_security_group_ids      = [aws_security_group.sandbox-security_group.id]
  subnet_id                   = aws_subnet.sandbox-subnet_public.id
  associate_public_ip_address = true
}
