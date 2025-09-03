variable "ami-id" {
    description = "AMI ID"
    default = "ami-02d26659fd82cf299"
}

variable "instance-type" {
    description = "Instance Type"
    default = "t3.micro"
}

variable "key-name" {
    description = "Key pair name"
    default = "first-key-pair"
}