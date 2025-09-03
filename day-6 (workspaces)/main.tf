/*
This is to modularize the terraform program to create infra for different workspace dev, stage, prod
Based on the workspace selection the ec2 instance type will selected dynamically
The variable "terraform.workspace" in the instance_type of the resouece is default keyword provided by terraform, this is will select(lookup) the value provided in terraform.tfvars file
We can have a terraform.tfvars file for each env like dev.tfvars, stage.tfvars and prod.tf vars this will also works, the present approach which is map and lookup the values is more dynamic in nature
*/
resource "aws_instance" "my-instance" {
    ami = var.ami-id
    instance_type = lookup(var.instance-type, terraform.workspace, "t3.micro")
    key_name = var.key-name
}