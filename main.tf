# Copyright IBM Corp. 2021, 2026

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