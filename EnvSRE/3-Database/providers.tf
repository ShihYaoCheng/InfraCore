# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-db.json")
}

provider "google-beta" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-db.json")
}

provider "mysql" {
  endpoint = module.database.PublicIP
  username = module.database.AdminName
  password = var.CloudSQLAdminPassword
}

terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.0.11"

  required_providers {
      # https://registry.terraform.io/providers/winebarrel/mysql/latest
    mysql = {
      source = "winebarrel/mysql"
      version = "1.10.6"
    }
  }
}