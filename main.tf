# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {

  backend "remote" {
    organization = "erikcorp"

    workspaces {
      name = "terraforming-with-freeman"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.58.0"
    }
  }
}

provider "google" {
  project = "terraforming-with-freeman"
}

data "google_project" "project" {
}