terraform {
  required_version = "1.6.1"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Secret token for DigitalOcean
variable "do_token" {
  sensitive = true
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}
