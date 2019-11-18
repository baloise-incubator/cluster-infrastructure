resource "hcloud_ssh_key" "main" {
  name       = "main"
  public_key = file("${path.module}/keys/id_rsa.pub")
}

data "template_file" "init-lb" {
  count    = var.lb_count
  template = file("${path.module}/tpl/cloud-init.tpl")
  vars = {
    hostname = "lb{count.index}.${var.nodes_subdomain}.${var.base_domain}"
  }
}

data "template_file" "init-bastion" {
  template = file("${path.module}/tpl/cloud-init.tpl")
  vars = {
    hostname = "bastion.${var.nodes_subdomain}.${var.base_domain}"
  }
}

data "template_file" "init-master" {
  count    = var.master_count
  template = file("${path.module}/tpl/cloud-init.tpl")
  vars = {
    hostname = "master{count.index}.${var.nodes_subdomain}.${var.base_domain}"
  }
}

data "template_file" "init-worker" {
  count    = var.worker_count
  template = file("${path.module}/tpl/cloud-init.tpl")
  vars = {
    hostname = "node{count.index}.${var.nodes_subdomain}.${var.base_domain}"
  }
}