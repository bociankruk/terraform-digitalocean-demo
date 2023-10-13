variable "region" {
  type        = string
  description = "Region name where app should be deployed."
}

variable "app_name" {
  type        = string
  description = "The uniqe name of the deployed app."
}

variable "app_domain" {
  type        = string
  description = "The name of the DNS domain."
}


variable "app_domain_id" {
  type        = string
  description = "The ID of the DNS domain."
}

variable "droplet_count" {
  type        = number
  description = "The amount of instances that this component should be scaled to."
  default     = 1
}

variable "droplet_size" {
  type        = string
  description = "The instance size to use for this component."
  default     = "s-1vcpu-1gb"
}

variable "droplet_user_data" {
  type        = string
  description = "A postinstall script content"
}

variable "app_http_port" {
  type = number
  description = "The http port on which application is running."
}

# variable "droplet_ssh_key" {
#   type = string
#   description = "A public SSH key to access droplet"
# }