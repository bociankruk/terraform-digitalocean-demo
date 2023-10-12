

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

resource "digitalocean_app" "app" {
  spec {
    name   = "${var.app_name}-app"
    region = var.region

    service {
      name               = "${var.app_name}-service"
      http_port          = var.app_http_port
      environment_slug   = var.app_environment_slug
      instance_count     = var.app_instance_count
      instance_size_slug = var.app_instance_size_slug
      run_command        = var.app_run_command
      git {
        repo_clone_url = var.app_git_repo
        branch         = var.app_git_branch
      }
    }
  }
}


resource "digitalocean_loadbalancer" "lb" {
  name                   = "${var.app_name}-lb"
  region                 = var.region
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 443
    protocol = "https"
    path     = "/health"
  }

  droplet_ids = [digitalocean_app.app.id]
}