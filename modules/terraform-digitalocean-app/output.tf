output "app_url" {
  value = "https://${digitalocean_record.cname.fqdn}"
}
