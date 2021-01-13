variable "aws_region" {
  description = "Region where you want to provision this EC2 WebServer"
  type        = string // number , bool
  default     = "ca-central-1"
}

variable "port_list" {
  description = "List of Poret to open for our WebServer"
  type        = list(any)
  default     = ["80", "443"]
}

variable "instance_size" {
  description = "EC2 Instance Size to provision"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags to Apply to Resources"
  type        = map(any)
  default = {
    Owner       = "Denis Astahov"
    Environment = "Prod"
    Project     = "Phoenix"
  }
}

variable "key_pair" {
  description = "SSH Key pair name to ingest into EC2"
  type        = string
  default     = "CanadaKey"
  sensitive   = true
}

variable "password" {
  description = "Please Enter Password lenght of 10 characters!"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.password) == 10
    error_message = "Your Password must be 10 characted exactly!!!"
  }
}
