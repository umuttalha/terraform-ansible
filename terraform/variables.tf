variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  sensitive   = true
}

variable "my_home_ip" {
  description = "my home ip for ssh"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "domain name"
  type        = string
  sensitive   = false
}
variable "ssh_key_name" {
  description = "ssh key name"
  type        = string
  sensitive   = true
}



