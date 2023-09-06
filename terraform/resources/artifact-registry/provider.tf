terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    bucket = "de6f0fe9cb3c1724-bucket-tfstate"
    prefix = "artifact-registry"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}