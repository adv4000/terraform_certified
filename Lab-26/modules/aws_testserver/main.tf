#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Provision Simple Web Server in specific Subnet
#
# Made by Denis Astahov
#----------------------------------------------------------

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_subnet" "web" { // Get VPC_ID
  id = var.subnet_id
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = var.subnet_id
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<HTMLTEXT > /var/www/html/index.html
<h2>
${var.name} WebServer with IP: $myip <br>
${var.name} WebServer in AZ: ${data.aws_subnet.web.availability_zone}<br>
Message:</h2> ${var.message}
HTMLTEXT

service httpd start
chkconfig httpd on
EOF
  tags = {
    Name  = "${var.name}-WebServer-${var.subnet_id}"
    Owner = "Denis Astahov"
  }
}

resource "aws_security_group" "webserver" {
  name_prefix = "${var.name} WebServer SG-"
  vpc_id      = data.aws_subnet.web.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.name}-web-server-sg"
    Owner = "Denis Astahov"
  }
}
