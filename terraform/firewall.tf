# Fetch Cloudflare IP ranges
data "http" "cloudflare_ips_v4" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ips_v6" {
  url = "https://www.cloudflare.com/ips-v6"
}

locals {
  cloudflare_ips = concat(
    split("\n", trimspace(data.http.cloudflare_ips_v4.response_body)),
    split("\n", trimspace(data.http.cloudflare_ips_v6.response_body))
  )
}

# Firewall setup
resource "hcloud_firewall" "cloudflare_firewall" {
  name = "cloudflare-firewall"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = local.cloudflare_ips
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = local.cloudflare_ips
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [var.my_home_ip]
  }
}

# Firewall attachment to the server
resource "hcloud_firewall_attachment" "web_firewall_attachment" {
  firewall_id = hcloud_firewall.cloudflare_firewall.id
  server_ids  = [hcloud_server.web.id]
}