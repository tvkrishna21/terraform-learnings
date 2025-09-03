output "public-dns" {
    value = aws_instance.my_tf_instance.public_dns
}

output "Public-ip" {
    value = aws_instance.my_tf_instance.public_ip
}