variable "aws_users" {
  description = "List of IAM Users to create"
  default = [
    "denis@astahov.net",
    "krisa@astahov.net",
    "kevin@astahov.net",
    "jessy@astahov.net",
    "robby@astahov.net",
    "laura@astahov.net",
    "katie@astahov.net",
    "josef@astahov.net"
  ]
}

variable "servers_settings" {
  type = map(any)
  default = {
    web = {
      ami           = "ami-0e472933a1395e172"
      instance_size = "t3.small"
      root_disksize = 20
      encrypted     = true
    }
    app = {
      ami           = "ami-07dd19a7900a1f049"
      instance_size = "t3.micro"
      root_disksize = 10
      encrypted     = false
    }
  }
}


variable "create_bastion" {
  description = "Provision Bastion Server YES/NO"
  default     = "NO"
}
