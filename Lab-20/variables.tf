variable "aws_users" {
  description = "List of IAM Users to create"
  default = [
    "denis@astahov.net",
    "krisa@astahov.net",
    "kevin@astahov.net",
    "jessy@astahov.net",
    "robby@astahov.net",
    "katie@astahov.net",
    "laura@astahov.net",
    "josef@astahov.net"
  ]
}

variable "create_bastion" {
  description = "Provision Bastion Server YES/NO"
  default     = "NO"
}
