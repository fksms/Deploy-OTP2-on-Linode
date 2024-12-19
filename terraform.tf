terraform {
  required_providers {
    linode = {
      source = "linode/linode" # https://registry.terraform.io/providers/linode/linode/latest
    }
  }
}

provider "linode" {
  token       = var.token
  api_version = "v4"
}
