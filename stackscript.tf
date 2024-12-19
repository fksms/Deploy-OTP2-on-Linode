# Provides a Linode StackScript resource

resource "linode_stackscript" "disable_root_script" {
  label       = "disable_root_script"
  description = "Disable root login"
  script      = <<EOF
#!/bin/bash

#<UDF name="username" label="Default Username">
#<UDF name="password" label="Default Password">
#<UDF name="publickey" label="SSH Public Key">

source <ssinclude StackScriptID=1>

if [ "$USERNAME" ] && [ "$PASSWORD" ] && [ "$PUBLICKEY" ]; then
    user_add_sudo "$USERNAME" "$PASSWORD"

    user_add_pubkey "$USERNAME" "$PUBLICKEY"
    
    ssh_disable_root
fi
EOF
  images      = ["any/all"]
}
