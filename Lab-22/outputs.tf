output "instances_ids" {
  value = aws_instance.my_server[*].id
}

output "instances_public_ips" {
  value = aws_instance.my_server[*].public_ip
}

output "server_id_ip" {
  value = [
    for x in aws_instance.my_server :
    "Server with ID: ${x.id} has Public IP: ${x.public_ip}"
  ]
}

output "server_id_ip_map" {
  value = {
    for x in aws_instance.my_server :
    x.id => x.public_ip // "i-12412412414435" = "15.33.77.104"
  }
}

output "users_unique_id_arn" {
  value = [
    for user in aws_iam_user.user :
    "UserID: ${user.unique_id} has ARN: ${user.arn}"
  ]
}

output "users_unique_id_name_custom" {
  value = {
    for user in aws_iam_user.user :
    user.unique_id => user.name // "AIDA4BML4S5345K74HQFF" : "john"
    if length(user.name) < 7
  }
}
