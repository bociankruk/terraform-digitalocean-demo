resource "digitalocean_domain" "domain" {
  name = var.app_domain
}

module "laravel-app" {
  source                 = "../../modules/terraform-azure-app"
  region                 = var.region
  app_name               = "laravel"
  app_domain             = var.app_domain
  app_domain_id          = digitalocean_domain.domain.id
  app_environment_slug   = "php"
  app_http_port          = 8080
  app_instance_count     = 1
  app_instance_size_slug = "basic-xxs"
  app_run_command        = "heroku-php-apache2 public/"
  app_git_repo           = "https://github.com/digitalocean/sample-laravel.git"
}
