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

# variable "app_git_repo" {
#   type        = string
#   description = "Git URL to the application repository"
# }

# variable "app_git_branch" {
#   type        = string
#   description = "Git branch to the application repository"
#   default     = "main"
# }

# variable "app_instance_count" {
#   type        = number
#   description = "The amount of instances that this component should be scaled to."
#   default     = 1
# }

# variable "app_instance_size_slug" {
#   type        = string
#   description = "The instance size to use for this component."
#   default     = "basic-xxs"
# }

# variable "app_environment_slug" {
#   type        = string
#   description = "An environment slug describing the type of this app."
# }
