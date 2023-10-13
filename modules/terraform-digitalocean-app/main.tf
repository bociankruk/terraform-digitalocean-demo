

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
  count     = var.droplet_count
  image     = "ubuntu-22-04-x64"
  name      = "${var.app_name}-${count.index}"
  region    = var.region
  size      = var.droplet_size
  tags      = [var.app_name]
  user_data = var.droplet_user_data
  # ssh_keys  = [var.droplet_ssh_key]
}

resource "digitalocean_loadbalancer" "lb" {
  name                   = "${var.app_name}-lb"
  region                 = var.region
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 8000
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 8000
    protocol = "http"
    path     = "/"
  }

  droplet_tag = var.app_name
}