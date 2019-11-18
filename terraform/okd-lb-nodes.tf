resource "hcloud_server" "lb" {
  count       = var.lb_count
  name        = "lb${count.index}.${var.nodes_subdomain}.${var.base_domain}"
  image       = var.image
  server_type = var.lb_server_type
  keep_disk   = true
  location    = var.region
  ssh_keys = [hcloud_ssh_key.main.id]
  user_data = data.template_file.init-lb[count.index].rendered
}

resource "hcloud_floating_ip" "api-lb" {
  type = "ipv4"
  server_id = "${hcloud_server.lb[0].id}"
}

resource "hcloud_floating_ip" "router-lb" {
  type = "ipv4"
  server_id = "${hcloud_server.lb[0].id}"
}

resource "cloudflare_record" "console" {
  zone_id = var.cf_zone_id
  name   = var.console_subdomain
  value  = hcloud_floating_ip.api-lb.ip_address
  type   = "A"
  ttl    = 120
}

resource "cloudflare_record" "lb" {
  count  = var.lb_count
  zone_id = var.cf_zone_id
  name   = "lb${count.index}.${var.nodes_subdomain}"
  value  = hcloud_server.lb[count.index].ipv4_address
  type   = "A"
  ttl    = 120
}