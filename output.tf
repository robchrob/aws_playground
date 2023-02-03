output "public_ip" {
  value = aws_instance.sandbox-server.public_ip
}

output "public_dns" {
  value = aws_instance.sandbox-server.public_dns
}

output "private_key" {
  value     = tls_private_key.sandbox-key.private_key_pem
  sensitive = true
}

output "username" {
  value = var.ec2_username
}

output "server_id" {
  value = aws_instance.sandbox-server.id
}
