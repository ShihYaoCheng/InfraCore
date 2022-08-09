# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = local.GCPRegion # assign default value.
  zone    = local.GCPZone   # assign default value.
}

provider "google-beta" {
  project = local.ProjectID # assign default value.
  region  = local.GCPRegion # assign default value.
  zone    = local.GCPZone   # assign default value.
}

provider "mysql" {
  endpoint = module.database.PublicIP
  username = module.database.AdminName
  password = "admin1234"
}

terraform {
  backend "http" {}

  required_providers {
      # https://registry.terraform.io/providers/winebarrel/mysql/latest
    mysql = {
      source = "winebarrel/mysql"
      version = "1.10.6"
    }
  }
}
