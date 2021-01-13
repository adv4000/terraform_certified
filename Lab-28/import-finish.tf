#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Import Existing Resource into Terraform code Complete like this
#
# Made by Denis Astahov
#-------------------------------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}


resource "aws_instance" "node1" {
  ami                    = "ami-07dd19a7900a1f049"
  instance_type          = "t3.micro"
  ebs_optimized          = true
  vpc_security_group_ids = [aws_security_group.k8s.id]
  tags = {
    "Name"  = "K8s Cluster Node-1"
    "Owner" = "Denis Astahov"
  }
}

resource "aws_instance" "node2" {
  ami                    = "ami-07dd19a7900a1f049"
  instance_type          = "t3.micro"
  ebs_optimized          = true
  vpc_security_group_ids = [aws_security_group.k8s.id]
  tags = {
    "Name"  = "K8s Cluster Node-2"
    "Owner" = "Denis Astahov"
  }
}

resource "aws_instance" "node3" {
  ami                    = "ami-07dd19a7900a1f049"
  instance_type          = "t3.micro"
  ebs_optimized          = true
  vpc_security_group_ids = [aws_security_group.k8s.id]
  tags = {
    "Name"  = "K8s Cluster Node-3"
    "Owner" = "Denis Astahov"
  }
}


resource "aws_security_group" "k8s" {
  description = "K8s-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Owner = "Denis Astahov"
  }
}
