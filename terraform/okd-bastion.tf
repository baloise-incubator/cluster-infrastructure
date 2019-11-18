resource "hcloud_server" "bastion" {
  name        = "bastion.${var.nodes_subdomain}.${var.base_domain}"
  image       = var.image
  server_type = var.bastion_server_type
  keep_disk   = true
  location    = var.region
  ssh_keys = [hcloud_ssh_key.main.id]

  user_data = data.template_file.init-bastion.rendered


}

resource "null_resource" "bastion_post_deploy" {
  connection {
    host        = hcloud_server.bastion.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file("${path.module}/keys/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
    "mkdir -p /root/inventory/group_vars/OSEv3/"]
  }

  provisioner "file" {
    source      = "${path.module}/keys/id_rsa"
    destination = "/root/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/install.sh"
  }
}

resource "cloudflare_record" "bastion" {
  zone_id = var.cf_zone_id
  name   = "bastion.${var.nodes_subdomain}.${var.base_domain}"
  value  = hcloud_server.bastion.ipv4_address
  type   = "A"
  ttl    = 120
}
