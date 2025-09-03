provider "aws" {
    region = "ap-south-1"
}

module "ec2_instance"  {
    source = "./modules/ec2_instance"
    ami-id = "ami-0861f4e788f5069dd"
    instance-type = "t3.micro"
    subnet-id = "subnet-0eeb1d389fc3b4b41"
}