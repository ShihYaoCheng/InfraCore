terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.2.9"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source = "hashicorp/google"
      version = "~>4.37.0"
    }

    # https://registry.terraform.io/providers/winebarrel/mysql/latest
    mysql = {
      source = "winebarrel/mysql"
      version = "1.10.6"
    }

    # https://registry.terraform.io/providers/hashicorp/random/latest
    random = {
      source = "hashicorp/random"
      version = "3.1.3"
    }
  }
}


