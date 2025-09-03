provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "Terraform_created_instance_with_remote_backen" {
    ami = var.ami-id
    instance_type = var.instance-type
}