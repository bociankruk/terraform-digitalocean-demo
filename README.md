# terraform-digitalocean-demo

## Descirption
The purpose of this repository is to deploy virtual machines (droplets) in DigitalOcean with Terraform cloud.

Key features:
* CI/CD workflow with GitHub action
  * On each PR code is validated and terraform plan is called to check what is going to be changed.
  * On merge to main branch, changes are automatically applied.
* Virtual machines are running web apps and all traffic is exposed by LoadBalander with SSL termination.
* Secured access to virtual machines, only SSH access is allowed.
* SSL certificate is genetrated by Let's Encrypt.
* Simple monitoring alerts for VMs.

Things to improve:
* Use prebuilt Vm images with installed required software like docker, docker-compose.
* Run web apps with from images that were already built and published on container registry.
