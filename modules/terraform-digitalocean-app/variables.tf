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
  type        = number
  description = "The http port on which application is running."
}

variable "monitor_email" {
  type        = string
  description = "Email address where alerts will be sent."
}

variable "monitor_cpu_thr" {
  type        = number
  description = "Percetnage of CPU usage threshold to trigger alert."
  default     = 90
}

variable "monitor_ram_thr" {
  type        = number
  description = "Percetnage of RAM usage threshold to trigger alert."
  default     = 90
}

variable "monitor_disk_thr" {
  type        = number
  description = "Percetnage of disk usage threshold to trigger alert."
  default     = 70
}