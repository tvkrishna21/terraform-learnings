output "instance-id" {
    value = aws_instance.my-instance.id
}

output "Public-DNS" {
    value = aws_instance.my-instance.public_dns
}