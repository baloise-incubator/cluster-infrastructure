resource "hcloud_server" "master" {
  count       = var.master_count
  name        = "master${count.index}.${var.nodes_subdomain}.${var.base_domain}"
  image       = var.image
  server_type = var.master_server_type
  keep_disk   = true
  location    = var.region
  ssh_keys = [hcloud_ssh_key.main.id]
  user_data = data.template_file.init-master[count.index].rendered
}

resource "cloudflare_record" "master" {
  count  = var.master_count
  zone_id = var.cf_zone_id
  name   = "master${count.index}.${var.nodes_subdomain}"
  value  = hcloud_server.master[count.index].ipv4_address
  type   = "A"
  ttl    = 120
}

