variable "token" {}
variable "username" {}
variable "password" {}

variable "node_count" {
  default = 1
}

variable "create_instance_1" {
  default = {
    region = "ap-northeast" # Tokyo
    image  = "linode/ubuntu24.04"
    type   = "g6-standard-2"
  }
}

variable "public_ssh_key" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "private_ssh_key" {
  default = "~/.ssh/id_ed25519"
}

resource "random_string" "root_pass" {
  length  = 32
  special = true
  upper   = true
  lower   = true
  numeric = true
}
