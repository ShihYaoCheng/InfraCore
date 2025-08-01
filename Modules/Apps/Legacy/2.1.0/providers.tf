﻿terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.0.11"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source = "hashicorp/google"
      version = "~>4.31.0"
    }

    # https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.6.0"
    }

    # https://registry.terraform.io/providers/hashicorp/kubernetes/latest
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}
