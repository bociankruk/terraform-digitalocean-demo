resource "digitalocean_domain" "domain" {
  name = var.app_domain
}

module "laravel-app" {
  source        = "../../modules/terraform-azure-app"
  region        = var.region
  app_name      = "laravel"
  app_domain    = var.app_domain
  app_domain_id = digitalocean_domain.domain.id
}
