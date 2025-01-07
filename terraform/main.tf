# Create Cloudflare DNS record 
# edit this with after for not www use cases
resource "cloudflare_record" "web" {
  zone_id = var.cloudflare_zone_id                # Cloudflare  Zone ID
  name    = "www"                                 # 
  content = hcloud_server.web.ipv4_address        # server IPv4 adress
  type    = "A"                                   # DNS record type
  proxied = true                                  # Cloudflare proxy
}

# create server
resource "hcloud_server" "web" {
  name        = "web-server"
  image       = "ubuntu-24.04"
  server_type = "cax11"
  location    = "nbg1"
  
}

