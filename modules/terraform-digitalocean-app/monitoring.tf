resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = [var.monitor_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = var.monitor_cpu_thr
  enabled     = true
  tags        = [var.app_name]
  description = "${var.app_name}-high-cpu-usage"
}

resource "digitalocean_monitor_alert" "ram_alert" {
  alerts {
    email = [var.monitor_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/memory_utilization_percent"
  compare     = "GreaterThan"
  value       = var.monitor_ram_thr
  enabled     = true
  tags        = [var.app_name]
  description = "${var.app_name}-high-ram-usage"
}

resource "digitalocean_monitor_alert" "disk_alert" {
  alerts {
    email = [var.monitor_email]
  }
  window      = "5m"
  type        = "v1/insights/droplet/disk_utilization_percent"
  compare     = "GreaterThan"
  value       = var.monitor_disk_thr
  enabled     = true
  tags        = [var.app_name]
  description = "${var.app_name}-high-disk-usage"
}