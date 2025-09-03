output "Instance-Public-DNS" {
    value = aws_instance.Terraform_created_instance_with_remote_backen.public_dns
}