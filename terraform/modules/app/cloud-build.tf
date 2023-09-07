resource "google_cloudbuild_trigger" "app" {
  location = var.region
  name     = "cloudbuild-sample-api"

   source_to_build {
    uri       = "https://github.com/tokku5552/nextjs-gcp-sample"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "terraform/resources/environments/${var.environment}/app/cloudbuild.yaml"
    uri       = "https://github.com/tokku5552/nextjs-gcp-sample"
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }
}