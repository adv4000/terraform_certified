#------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Generate, Store and Retrieve Password Using AWS Secrets Manager
#
# Made by Denis Astahov
#------------------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

resource "aws_db_instance" "prod" {
  identifier           = "prod-mysql-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  username             = "administrator"
  password             = data.aws_secretsmanager_secret_version.rds_password.secret_string
}

// Generate Password
resource "random_password" "main" {
  length           = 20
  special          = true #   Default: !@#$%&*()-_=+[]{}<>:?
  override_special = "#!()_"
}

// Store Password
resource "aws_secretsmanager_secret" "rds_password" {
  name                    = "/prod/rds/password"
  description             = "Password for my RDS Database"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.main.result
}


// Store All RDS parameters
resource "aws_secretsmanager_secret" "rds" {
  name                    = "/prod/rds/all"
  description             = "All Details for my RDS Database"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds" {
  secret_id = aws_secretsmanager_secret.rds.id
  secret_string = jsonencode({
    rds_address  = aws_db_instance.prod.address
    rds_port     = aws_db_instance.prod.port
    rds_username = aws_db_instance.prod.username
    rds_password = random_password.main.result
  })
}


// Retrieve Password
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id  = aws_secretsmanager_secret.rds_password.id
  depends_on = [aws_secretsmanager_secret_version.rds_password]
}

// Retreive ALL
data "aws_secretsmanager_secret_version" "rds" {
  secret_id  = aws_secretsmanager_secret.rds.id
  depends_on = [aws_secretsmanager_secret_version.rds]
}


#-------
output "rds_address" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_address"]
}

output "rds_port" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_port"]
}

output "rds_username" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_username"]
}

output "rds_password" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_password"]
  sensitive = true
}

output "rds_all" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}
