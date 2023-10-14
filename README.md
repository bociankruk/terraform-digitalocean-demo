# terraform-digitalocean-demo

## Descirption
The purpose of this repository is to deploy virtual machines (droplets) in DigitalOcean with Terraform cloud.

Key features:
* Secured access to virtual machines, only SSH access is allowed.
* Virtual machines are running applications and all traffic is exposed by LoadBalander with SSL termination.
* SSL certificate is genetrated by Let's Encrypt.
* Simple monitoring alerts for VMs.
