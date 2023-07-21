terraform {
  required_providers {
    akeyless = {
      version = ">= 1.0.0"
      source  = "akeyless-community/akeyless"
    }
  }

  cloud {
    organization = "work-demos"

    workspaces {
      name = "terraform-cloud-intro"
    }
  }
}

provider "akeyless" {
  api_gateway_address = "https://api.akeyless.io"

  jwt_login {
    access_id = "p-96bszq455x2z"
    jwt       = var.AKEYLESS_AUTH_JWT_DEBUG
  }
}

variable "AKEYLESS_AUTH_JWT_DEBUG" {
  type        = string
  description = "Terraform Cloud Workload Identity JWT for authentication into Akeyless. Provided by Terraform Cloud through an agent pool and hooks."
}

resource "akeyless_static_secret" "secret" {
  path  = "/terraform-tests/secret"
  value = "this value was set from terraform"
}

data "akeyless_secret" "secret" {
  depends_on = [
    akeyless_static_secret.secret
  ]
  path = "/terraform-tests/secret"
}
