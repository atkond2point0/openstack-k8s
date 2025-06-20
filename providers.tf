terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.49.0"
    }
  }
}

provider "openstack" {
  user_name = "user_practice_25_02"
  password  = "C0?3%QZUwQVjb2"
  auth_url  = "https://cloud.atomlabs.ru:5000/v3/"
  region    = "RegionOne"
  cloud     = "openstack"
}

