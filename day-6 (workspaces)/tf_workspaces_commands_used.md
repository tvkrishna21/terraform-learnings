# Terraform workspaces 

```
terraform workspace show
> default
```
```
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```
```
terraform workspace list
>   default
  dev
* prod
  stage
```
```
terraform workspace select dev
```
```
terraform workspace show
> dev
```
```
terraform apply
```
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.my-instance will be created
  + resource "aws_instance" "my-instance" {
      + ami                                  = "ami-02d26659fd82cf299"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "first-key-pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-south-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Public-DNS  = (known after apply)
  + instance-id = (known after apply)

Do you want to perform these actions in workspace "dev"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.my-instance: Creating...
aws_instance.my-instance: Still creating... [00m10s elapsed]
aws_instance.my-instance: Creation complete after 12s [id=i-07bcb59f6b62ff9a9]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

Public-DNS = "ec2-13-203-193-239.ap-south-1.compute.amazonaws.com"
instance-id = "i-07bcb59f6b62ff9a9"
```

#### Terraform Workspaces will create a statefile for each of the workspace in terraform.tfstate.d dir

```
ubuntu@ip-172-31-12-43:~/tf$ cd terraform.tfstate.d/
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d$ ls -l
total 12
drwxr-xr-x 2 ubuntu ubuntu 4096 Aug 25 09:24 dev
drwxr-xr-x 2 ubuntu ubuntu 4096 Aug 25 09:15 prod
drwxr-xr-x 2 ubuntu ubuntu 4096 Aug 25 09:14 stage
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d$ cd dev/
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d/dev$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu 5282 Aug 25 09:24 terraform.tfstate ---> This is the statefile for dev workspace
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d/dev$ cd ../prod/
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d/prod$ ls -l
total 0 ----------------------------------------------------------> No statefile because we didn't perform any terraform process in stage and prod workspaces
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d/prod$ 
```

#### Now switch to stage workspace and run terrform apply --> we use this same command "terraform apply" which will select the instance type based on workspace we run the command

```
ubuntu@ip-172-31-12-43:~/tf$ terraform workspace select stage
Switched to workspace "stage".
ubuntu@ip-172-31-12-43:~/tf$ terraform workspace show
stage
ubuntu@ip-172-31-12-43:~/tf$ terraform apply
```
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.my-instance will be created
  + resource "aws_instance" "my-instance" {
      + ami                                  = "ami-02d26659fd82cf299"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "first-key-pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-south-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Public-DNS  = (known after apply)
  + instance-id = (known after apply)

Do you want to perform these actions in workspace "stage"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.my-instance: Creating...
aws_instance.my-instance: Still creating... [00m10s elapsed]
aws_instance.my-instance: Creation complete after 12s [id=i-0464111cb3abd5f24]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

Public-DNS = "ec2-15-206-174-114.ap-south-1.compute.amazonaws.com"
instance-id = "i-0464111cb3abd5f24"
ubuntu@ip-172-31-12-43:~/tf$ 
```

#### Now if we see will have a statefile for stage as well

```
ubuntu@ip-172-31-12-43:~/tf$ cd terraform.tfstate.d/stage/
ubuntu@ip-172-31-12-43:~/tf/terraform.tfstate.d/stage$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu 5282 Aug 25 09:32 terraform.tfstate
```

#### Do this for prod workspaces as well
