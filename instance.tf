# Provides a Linode Instance resource

resource "linode_instance" "instance_1" {
  count           = var.node_count
  label           = "test-instance-${count.index + 1}"
  region          = var.create_instance_1.region
  image           = var.create_instance_1.image
  type            = var.create_instance_1.type
  authorized_keys = ["${chomp(file(var.public_ssh_key))}"]

  root_pass  = random_string.root_pass.result
  private_ip = true

  stackscript_id = linode_stackscript.disable_root_login_script.id
  stackscript_data = {
    "username"  = var.username
    "password"  = var.password
    "publickey" = "${chomp(file(var.public_ssh_key))}"
  }

  provisioner "file" {
    source      = "download_assets.sh"
    destination = "/tmp/download_assets.sh"
  }

  provisioner "remote-exec" {
    inline = [
      # Install Docker
      "curl https://get.docker.com | sudo sh",

      # Download Assets
      "chmod +x /tmp/download_assets.sh",
      "sh /tmp/download_assets.sh",

      # Clone Repository
      "git clone https://github.com/fksms/Deploy-OTP2-on-Docker.git",

      # Move Assets
      "mv graph.obj Deploy-OTP2-on-Docker/otp/",

      # Change Directory
      "cd Deploy-OTP2-on-Docker",

      # Build App
      "sudo docker compose -f load_graph_and_deploy_middle.yml build",

      # Start App
      "sudo docker compose -f load_graph_and_deploy_middle.yml up -d",
    ]
  }

  connection {
    type        = "ssh"
    private_key = file(var.private_ssh_key)
    user        = var.username
    host        = self.ip_address
  }
}
