#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Set S3 Backend for Terraform Remote State
# Get Outputs from another Terraform Remote State
# Deploy Web Layer
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "eu-north-1"
}


terraform { // This is to Store Remote State
  backend "s3" {
    bucket = "adv-it-terraform-remote-state"   // Bucket where to SAVE Terraform State
    key    = "dev/webserver/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-west-2"                       // Region where bucket created
  }
}


data "terraform_remote_state" "vpc" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "adv-it-terraform-remote-state" // Bucket from where to GET Terraform State
    key    = "dev/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-west-2"                     // Region where bucket created
  }
}


#--------------------------
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform with Remote State"  >  /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF
  tags = {
    Name  = "${var.env}-WebServer"
    Owner = "Denis Astahov"
  }
}

resource "aws_security_group" "webserver" {
  name   = "WebServer Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.env}-web-server-sg"
    Owner = "Denis Astahov"
  }
}
