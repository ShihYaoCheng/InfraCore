﻿terraform {
  backend "http" {}
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = var.GCPRegion   # assign default value.
  zone    = var.GCPZone     # assign default value.
}

provider "google-beta" {
  project = local.ProjectID # assign default value.
  region  = var.GCPRegion   # assign default value.
  zone    = var.GCPZone     # assign default value.
}

provider "mysql" {
  endpoint = module.DB.PublicIP
  username = module.DB.AdminName
  password = var.CloudSQLAdminPassword
}

terraform {
  required_providers {
    # https://registry.terraform.io/providers/winebarrel/mysql/latest
    mysql = {
      source  = "winebarrel/mysql"
      version = "1.10.6"
    }
  }
}