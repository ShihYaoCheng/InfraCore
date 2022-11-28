terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.2.9"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source = "hashicorp/google"
      version = "~>4.44.0"
    }

    # https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }

    # https://registry.terraform.io/providers/hashicorp/kubernetes/latest
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.0"
    }
  }
}