provider "hcloud" {
  token = var.hcloud_token
}

provider "cloudflare" {
  api_token = var.cf_token
}