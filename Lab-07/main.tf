#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Implicit dependency - by reference another resource attribute
# Explicit dependency - by specify depend_on = []
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_server_web" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-Web" }

  depends_on = [
    aws_instance.my_server_db,
    aws_instance.my_server_app
  ]
}

resource "aws_instance" "my_server_app" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-App" }

  depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_db" {
  ami                    = "ami-0bd39c806c2335b95"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Server-DB" }
}


resource "aws_security_group" "general" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "3389"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My SecurityGroup"
  }
}
