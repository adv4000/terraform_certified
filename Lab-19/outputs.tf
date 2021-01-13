output "server_id" {
  value = aws_instance.my_server.id
}

output "server_public_ip" {
  value = aws_instance.my_server.public_ip
}
