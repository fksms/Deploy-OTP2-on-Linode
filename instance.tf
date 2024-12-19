# Provides a Linode Instance resource

resource "linode_instance" "instance1" {
  count           = var.node_count
  label           = "test-instance-${count.index + 1}"
  region          = var.create_instance1.region
  image           = var.create_instance1.image
  type            = var.create_instance1.type
  authorized_keys = ["${chomp(file(var.public_ssh_key))}"]

  root_pass  = random_string.root_pass.result
  private_ip = true

  stackscript_id = linode_stackscript.disable_root_script.id
  stackscript_data = {
    "username"  = var.username
    "password"  = var.password
    "publickey" = "${chomp(file(var.public_ssh_key))}"
  }
}