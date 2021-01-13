#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Execute Commands on Remote Server
#
# Made by Denis Astahov
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}


resource "aws_instance" "myserver" {
  ami                    = "ami-0c9bfc21ac5bf10eb"
  instance_type          = "t3.nano"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = "denis-key-ca-central-1"
  tags = {
    Name  = "My EC2 with remote-exec"
    Owner = "Denis Astahov"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ec2-user/terraform",
      "cd /home/ec2-user/terraform",
      "touch hello.txt",
      "echo 'Terraform was here...' > terraform.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip //Same as: aws_instance.myserver.public_ip
      private_key = file("denis-key-ca-central-1.pem")
    }
  }
}


resource "aws_security_group" "web" {
  name = "My-SecurityGroup"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "SG by Terraform"
    Owner = "Denis Astahov"
  }
}
