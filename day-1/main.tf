provider "aws" {
    region = "ap-south-1"

}

resource "aws_instance" "ubuntu_instance" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t3.micro"
    key_name = "first-key-pair"
    security_groups = ["sg-0c4cd7a9e2b127e22"]
    tags = {
        name = "Terraform-generated-instance"
    }

}