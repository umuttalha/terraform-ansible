

data "hcloud_ssh_key" "default" {
  name = var.ssh_key_name
}

# Create Cloudflare DNS record 

resource "cloudflare_record" "apex" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name                    # Root domain
  content = hcloud_server.web.ipv4_address     # Your IP address
  type    = "A"                                # DNS record type A for IP
  proxied = true                               # Enable Cloudflare proxy
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id                # Cloudflare Zone ID
  name    = "www"                                 # Subdomain www
  content = var.domain_name                       # Redirect to root domain
  type    = "CNAME"                               # DNS record type CNAME for alias
  proxied = true                                  # Enable Cloudflare proxy
}


# create server
resource "hcloud_server" "web" {
  name        = "web-server"
  image       = "ubuntu-24.04"
  server_type = "cax11"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.default.id]
}

