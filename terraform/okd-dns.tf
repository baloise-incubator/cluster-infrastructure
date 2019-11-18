resource "cloudflare_record" "apps" {
  zone_id  = var.cf_zone_id
  name   = var.apps_subdomain
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}

resource "cloudflare_record" "apps-wildcard" {
  zone_id  = var.cf_zone_id
  name   = "*.${var.apps_subdomain}"
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}

resource "cloudflare_record" "docs" {
  zone_id  = var.cf_zone_id
  name   = "docs"
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}


resource "cloudflare_record" "blog" {
  zone_id  = var.cf_zone_id
  name   = "blog"
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}

resource "cloudflare_record" "argocd" {
  zone_id  = var.cf_zone_id
  name   = "argocd"
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}

resource "cloudflare_record" "base" {
  zone_id  = var.cf_zone_id
  name   = "@"
  value  = hcloud_floating_ip.router-lb.ip_address
  type   = "A"
  ttl    = 120
}