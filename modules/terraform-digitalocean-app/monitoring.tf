resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = [var.monitoring_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = var.monitoring_cpu_threshold
  enabled     = true
  tags        = [var.var.app_name]
  description = "${var.app_name}-high-cpu-usage"
}

resource "digitalocean_monitor_alert" "ram_alert" {
  alerts {
    email = [var.monitoring_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/memory_utilization_percent"
  compare     = "GreaterThan"
  value       = var.monitoring_ram_threshold
  enabled     = true
  tags        = [var.var.app_name]
  description = "${var.app_name}-high-ram-usage"
}

resource "digitalocean_monitor_alert" "disk_alert" {
  alerts {
    email = [var.monitoring_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/disk_utilization_percent"
  compare     = "GreaterThan"
  value       = var.monitoring_disk_threshold
  enabled     = true
  tags        = [var.var.app_name]
  description = "${var.app_name}-high-disk-usage"
}