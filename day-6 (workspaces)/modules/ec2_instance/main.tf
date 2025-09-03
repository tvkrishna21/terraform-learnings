provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "my-instance" {
    ami = var.ami-id
    instance_type = var.instance_type
    key_name = var.key-name
}
