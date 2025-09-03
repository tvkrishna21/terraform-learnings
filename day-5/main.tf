provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    provisioner "local-exec" {
      command = "echo 'VPC has been created successfully as my-vpc, ID: ${self.id}' > local_vpc_id.txt"
    }
}

resource "tls_private_key" "my-tf-key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "my-tf-keypair" {
    key_name = "my-tf-keypair"
    public_key = tls_private_key.my-tf-key.public_key_openssh
}

resource "local_file" "private_key" {
    content = tls_private_key.my-tf-key.private_key_pem
    filename = "my-tf-keypair.pem"
    file_permission = "0400"
}

resource "aws_subnet" "my-subnet1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    provisioner "local-exec" {
        command = "echo 'Subnet has been created successfully as my-subnet1, ID: ${self.id}' > local_subnet_id.txt"      
    }
}

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id

    provisioner "local-exec" {
        command = "echo 'IGW has been created successfully as my-igw, ID: ${self.id}' > local_igw_id.txt"
    }
}

resource "aws_route_table" "my-route-table1" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }

    provisioner "local-exec" {
        command = "echo 'Route table has been created successfully as my-route-table1, ID: ${self.id}' > my_route_table.txt"     
    }
}

resource "aws_route_table_association" "my-rt-assoc" {
    subnet_id = aws_subnet.my-subnet1.id
    route_table_id = aws_route_table.my-route-table1.id

    provisioner "local-exec" {
        command = "echo 'Route table association has been created successfully as my-rt-assoc, ID: ${self.id}' > my_route_table_assoc.txt"
    } 
}

resource "aws_security_group" "websg" {
    name = "web"
    vpc_id = aws_vpc.my-vpc.id

    ingress {
        description = "HTTP from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH"
        from_port = 22
        to_port = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    provisioner "local-exec" {
        command = "echo 'Secruity Group has been created successfully as websg, ID: ${self.id}' > my_sg.txt"
    }      
}
  
resource "aws_instance" "python-server" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = aws_key_pair.my-tf-keypair.key_name
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id = aws_subnet.my-subnet1.id

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = tls_private_key.my-tf-key.private_key_pem
      host = self.public_ip
    }

    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
    }    

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from the remote instance'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "python3 -m venv venv",
            "source venv/bin/activate",
            "pip install flask",
            "deactivate",
            "sudo apt install python3-flask",
            "sudo nohup python3 app.py &",
         ]
    }

    provisioner "local-exec" {
        command = "echo 'VM has been created and copied app.py file from local to vm and then installed python3, flask and started the service, ID: ${self.id}' > local_instance.txt"
        }     
}