variable "image" {
  type    = "string"
  default = "centos-7"
}
variable bastion_server_type {
  type    = "string"
  default = "cx11-ceph"
}

variable "lb_count" {
  description = "LoadBalancer node count"
  type        = number
  default     = 1
}

variable lb_server_type {
  type    = "string"
  default = "cx11-ceph"
}

variable "master_count" {
  description = "Master node count"
  type        = number
  default     = 3
}

variable master_server_type {
  type    = "string"
  default = "cx31"
}

variable "worker_count" {
  description = "Compute node count"
  type        = number
  default     = 3
}

variable worker_server_type {
  type    = "string"
  default = "cx41"
}

variable "region" {
  description = "Create nodes in this regions"
  type        = string
  default     = "nbg1"
}

variable "base_domain" {
  description = "Base domain for the cluster"
  type        = string
}

variable nodes_subdomain {
  type    = "string"
  default = "okd"
}

variable apps_subdomain {
  type    = "string"
  default = "apps"
}

variable console_subdomain {
  type    = "string"
  default = "console"
}

variable "hcloud_token" {
  type    = "string"
}

variable "cf_email" {
  type    = "string"
}

variable "cf_token" {
  type    = "string"
}


variable "cf_zone_id" {
  type    = "string"
}

