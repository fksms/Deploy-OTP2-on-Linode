output "linode_instance_ip" {
  value = linode_instance.instance1.*.ip_address
}

output "linode_instance_password" {
  value = random_string.root_pass.result
}
