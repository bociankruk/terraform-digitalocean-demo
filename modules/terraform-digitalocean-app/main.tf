

resource "digitalocean_record" "a" {
  domain = var.app_domain_id
  type   = "A"
  name   = var.app_name
  value  = digitalocean_loadbalancer.lb.ip
}

resource "digitalocean_record" "cname" {
  domain = var.app_domain_id
  type   = "CNAME"
  name   = "www.${var.app_name}"
  value  = "${digitalocean_record.a.fqdn}."
}

resource "digitalocean_certificate" "cert" {
  name    = "${var.app_name}-le-cert"
  type    = "lets_encrypt"
  domains = ["${var.app_name}.${var.app_domain}", "www.${var.app_name}.${var.app_domain}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_droplet" "web" {
  count      = var.droplet_count
  image      = "ubuntu-22-04-x64"
  name       = "${var.app_name}-${count.index}"
  region     = var.region
  size       = var.droplet_size
  tags       = [var.app_name]
  user_data  = var.droplet_user_data
  monitoring = true
}

resource "digitalocean_firewall" "web" {
  name        = "${var.app_name}-fw-allow-only-ssh"
  droplet_ids = digitalocean_droplet.web[*].id
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol                  = "tcp"
    port_range                = var.app_http_port
    source_load_balancer_uids = [digitalocean_loadbalancer.lb.id]
  }
  outbound_rule {
    protocol                       = "tcp"
    port_range                     = var.app_http_port
    destination_load_balancer_uids = [digitalocean_loadbalancer.lb.id]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_loadbalancer" "lb" {
  name                   = "${var.app_name}-lb"
  region                 = var.region
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = var.app_http_port
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = var.app_http_port
    protocol = "http"
    path     = "/"
  }

  droplet_tag = var.app_name
}