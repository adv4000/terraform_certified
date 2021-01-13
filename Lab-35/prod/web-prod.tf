#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
#  Call Global Variables module and use their outputs
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
module "global" {
  source = "../global_vars"
}

resource "aws_instance" "web-prod" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = module.global.prod_server_size
  vpc_security_group_ids = [aws_security_group.web-prod.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>PROD WebServer with IP: $myip</h2><br>Build by Terraform!"  >  /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF

  tags = merge({
    Name  = "PROD WebServer"
    Owner = "Denis Astahov"
  }, module.global.tags)
}

resource "aws_security_group" "web-prod" {
  name        = "WebServer SG Prod"
  description = "My First SecurityGroup"

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
    Name  = "Web Server SecurityGroup"
    Owner = "Denis Astahov"
  }
}
