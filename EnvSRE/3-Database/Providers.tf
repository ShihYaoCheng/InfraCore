# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = var.GCPRegion   # assign default value.
  zone    = var.GCPZone     # assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-db.json")
}

provider "google-beta" {
  project = local.ProjectID # assign default value.
  region  = var.GCPRegion   # assign default value.
  zone    = var.GCPZone     # assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-db.json")
}

provider "mysql" {
  endpoint = module.database.PublicIP
  username = module.database.AdminName
  password = local.CloudSQLAdminPassword
}

terraform {
  required_providers {
      # https://registry.terraform.io/providers/winebarrel/mysql/latest
    mysql = {
      source = "winebarrel/mysql"
      version = "1.10.6"
    }
  }
}