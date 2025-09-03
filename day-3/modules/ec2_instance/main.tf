resource "aws_instance" "my_tf_instance" {
    ami = var.ami-id
    instance_type = var.instance-type
    subnet_id = var.subnet-id
}