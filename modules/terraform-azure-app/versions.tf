terraform {
  required_version = "1.6.1"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
        version = "~> 2.0"
    }
  }
}
