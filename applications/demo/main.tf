resource "digitalocean_domain" "domain" {
  name = var.app_domain
}

data "local_file" "user_data" {
  filename = "${path.module}/files/install-laravel.sh"
}

module "laravel-app" {
  source            = "../../modules/terraform-digitalocean-app"
  droplet_count     = 1
  droplet_user_data = file("files/user_data.yaml")
  region            = var.region
  app_name          = "laravel"
  app_domain        = var.app_domain
  app_domain_id     = digitalocean_domain.domain.id
  app_http_port     = 8000
}
