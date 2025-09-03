terraform {
  backend "s3" {
    bucket = "test-user-bucket-for-api-unique"
    key = "vamshi/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "terraform-lock"    
  }
}