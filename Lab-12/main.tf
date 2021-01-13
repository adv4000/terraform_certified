#------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Fetch and use information of:
#  Latest AMI id of Ubuntu 20.04
#  Latest AMI id of Amazon Linux2
#  Latest AMI id of Windows Server 2019
#
# Made by Denis Astahov
#------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}


data "aws_ami" "latest_ubuntu20" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazonlinux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windowserver2019" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}


# ---------How to use
/*
resource "aws_instance" "server_ubuntu" {
  ami           = data.aws_ami.latest_ubuntu20.id
  instance_type = "t3.micro"
}


resource "aws_instance" "server_amazon" {
  ami           = data.aws_ami.latest_amazonlinux.id
  instance_type = "t3.micro"
}


resource "aws_instance" "server_windows" {
  ami           = data.aws_ami.latest_windowserver2019.id
  instance_type = "t3.micro"
}
*/

#------------------

output "latest_ubuntu20_ami_id" {
  value = data.aws_ami.latest_ubuntu20.id
}

output "latest_amazonlinux_ami_id" {
  value = data.aws_ami.latest_amazonlinux.id
}

output "latest_windowserver2019_ami_id" {
  value = data.aws_ami.latest_windowserver2019.id
}
