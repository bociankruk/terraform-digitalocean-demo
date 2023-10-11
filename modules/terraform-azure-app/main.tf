resource "digitalocean_certificate" "cert" {
  name    = "${var.app_name}-le-cert"
  type    = "lets_encrypt"
  domains = ["example.com"]
}

resource "digitalocean_app" "app" {
  spec {
    name   = "${var.app_name}-app"
    region = var.region

    service {
      name               = "${var.app_name}-service"
      environment_slug   = var.app_environment_slug
      instance_count     = var.app_instance_count
      instance_size_slug = var.app_instance_size_slug

      git {
        repo_clone_url = var.app_git_repo
        branch         = var.app_git_branch
      }
    }
  }
}


resource "digitalocean_loadbalancer" "public" {
  name   = "${var.app_name}-lb"
  region = var.region

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_app.app.id]
}