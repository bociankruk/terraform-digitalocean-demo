resource "digitalocean_domain" "domain" {
  name = var.app_domain
}

module "laravel-app" {
  source            = "../../modules/terraform-digitalocean-app"
  droplet_count     = 2
  droplet_user_data = file("files/laravel_user_data.yaml")
  region            = var.region
  app_name          = "laravel"
  app_domain        = var.app_domain
  app_domain_id     = digitalocean_domain.domain.id
  app_http_port     = 8000
  monitor_email     = "bociankruk@gmail.com"
  monitor_cpu_thr   = 90
  monitor_ram_thr   = 95
}

module "angular-app" {
  source            = "../../modules/terraform-digitalocean-app"
  droplet_count     = 2
  droplet_user_data = file("files/angular_user_data.yaml")
  region            = var.region
  app_name          = "angular"
  app_domain        = var.app_domain
  app_domain_id     = digitalocean_domain.domain.id
  app_http_port     = 4200
  monitor_email     = "bociankruk@gmail.com"
  monitor_cpu_thr   = 80
}
