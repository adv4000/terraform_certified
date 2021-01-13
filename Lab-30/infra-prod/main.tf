#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Manipulation with Remote State, Refactoring Terraform Code
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
