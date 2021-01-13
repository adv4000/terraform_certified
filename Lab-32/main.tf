#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Terraform Logs
# Log Levels: TRACE, DEBUG, INFO, WARN, ERROR
# Enable Logs:
#   export TF_LOG=ERROR
#   export TF_LOG_PATH=terraform.logs
#
# Disable Logs:
#   unset TF_LOG
#   unset TF_LOG_PATH
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------

provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c9bfc21ac5bf10eb"
  instance_type = "t3.micro"
}
