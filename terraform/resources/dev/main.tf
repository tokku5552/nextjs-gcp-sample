provider "google" {
  project = "<プロジェクトID>"
  region  = "us-west1"
  zone    = "us-west1-a"
}

terraform {
  backend "gcs" {
    bucket  = "my-terraform-bucket"
  }
}