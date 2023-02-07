resource "aws_instance" "sandbox-server" {
  ami           = data.aws_ami.latest_ami.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.sandbox-key_pair.key_name

  vpc_security_group_ids      = [aws_security_group.sandbox-security_group.id]
  subnet_id                   = aws_subnet.sandbox-subnet_public.id
  associate_public_ip_address = true


  user_data = <<-EOL
    #!/bin/bash -xe

    mkdir actions-runner && cd actions-runner

    curl -o actions-runner-linux-x64-2.301.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz

    tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz

    ./config.sh --url https://github.com/robchrob/python-boilerplate --token AAQGTIPOVDILMYUXABB3KLLD4GOII
    EOL
}
