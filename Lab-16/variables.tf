variable "environment" {
  default = "DEV"
}

variable "project_name" {
  default = "ANDESA"
}

variable "owner" {
  default = "Denis Astahov"
}

variable "tags" {
  default = {
    budged_code = 11223344
    Manager     = "Elon Mask"
    Planet      = "Mars"
  }
}
