output "user_arns" {
  value = values(aws_iam_user.user)[*].arn
}

output "prod_instance_id" {
  value = aws_instance.my_server["Prod"].id
}

output "instances_ids" {
  value = values(aws_instance.my_server)[*].id
}

output "instances_public_ips" {
  value = values(aws_instance.my_server)[*].public_ip
}

output "bastion_public_ip" {
  value = var.create_bastion == "YES" ? aws_instance.bastion_server["bastion"].public_ip : null
}
