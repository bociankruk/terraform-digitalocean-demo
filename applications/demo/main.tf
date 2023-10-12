resource "digitalocean_domain" "domain" {
  name = var.app_domain
}

data "local_file" "user_data" {
  filename = "${path.module}/files/user_data"
}

module "laravel-app" {
  source            = "../../modules/terraform-digitalocean-app"
  droplet_count     = 1
  droplet_user_data = data.local_file.user_data.content
  region            = var.region
  app_name          = "laravel"
  app_domain        = var.app_domain
  app_domain_id     = digitalocean_domain.domain.id
}
