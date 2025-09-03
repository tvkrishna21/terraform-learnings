provider "aws" {
    region = "ap-south-1"  
}

provider "vault" {
  address = "http://13.201.20.191:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "aa6ea00a-fc78-a962-bcc5-257438c81648"
      secret_id = "afee61c5-736d-3312-e8d7-dd7b2f1da7a4"
    }
  }  
}

data "vault_kv_secret_v2" "example" {
    mount = "kv"
    name = "test-secret"
}