#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Import Existing Resource into Terraform code Begin like this
#    1. terraform init
#    2. terraform import aws_instance.node1 i-01a1c2b58e21fa64c
#    3. terraform import aws_instance.node2 i-01d039a8106a24d19
#    4. terraform import aws_instance.node3 i-065d5e431adf1266a
#    5. terraform import aws_security_group.k8s sg-0e1bf8ce83c3f21b2
# Made by Denis Astahov
#-------------------------------------------------------------------------------


resource "aws_instance" "node1" {

}

resource "aws_instance" "node2" {

}

resource "aws_instance" "node3" {

}

resource "aws_security_group" "k8s" {

}
