#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# terraform apply -target=aws_instance.web
# terraform apply -target=aws_instance.web -auto-approve
# terraform show
# terraform output
# terraform validate
# terraform refresh
#
# terraform console
#  base64encode("Hello from Denis Astahov!")
#  base64decode("SGVsbG8gZnJvbSBEZW5pcyBBc3RhaG92IQ==")
#  sha256("Hello")
#  keys({Name="David", City="Vanocuver", Position="DevOps Engineer",  YOB = 1977})
#  values({Name="David", City="Vancouver", Position="DevOps Engineer",  YOB = 1977})
#  split(",", "david,john,sindy,keren")
#  upper("Hello")
#  lower("HELlo")
#  templatefile("user_data.sh.tpl", { f_name = "Denis", l_name = "Astahov", names = ["Name1", "Name2"]})
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-0c9bfc21ac5bf10eb" // Amazon Linux2
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh.tpl", { // Template File
    f_name = "Denis"
    l_name = "Astahov"
    names  = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Sonya"]
  })

  tags = {
    Name  = "WebServer Built by Terraform"
    Owner = "Denis Astahov"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my WebServer"

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Denis Astahov"
  }
}

resource "aws_eip" "ip1" {}
resource "aws_eip" "ip2" {}
resource "aws_eip" "ip3" {}

#-----
output "web_ip_address" {
  value = aws_instance.web.public_ip
}

output "web_id" {
  value = aws_instance.web.id
}

output "web_security_group_id" {
  value = aws_security_group.web.id
}
