
resource "hcloud_server" "worker" {
  count       = var.worker_count
  name        = "node${count.index}.${var.nodes_subdomain}.${var.base_domain}"
  image       = var.image
  server_type = var.worker_server_type
  keep_disk   = false
  location    = var.region
  ssh_keys = [hcloud_ssh_key.main.id]
  user_data = data.template_file.init-worker[count.index].rendered
}

resource "cloudflare_record" "worker" {
  count  = var.worker_count
  zone_id = var.cf_zone_id
  name   = "node${count.index}.${var.nodes_subdomain}"
  value  = hcloud_server.worker[count.index].ipv4_address
  type   = "A"
  ttl    = 120
}
