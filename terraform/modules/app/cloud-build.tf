resource "google_cloudbuildv2_connection" "github_connection" {
  location = var.region
  name = "github-connection"

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = var.github_oauth_token_secret_version
    }
  }
}

resource "google_cloudbuildv2_repository" "github_repository" {
  name = "github-repository"
  parent_connection = google_cloudbuildv2_connection.github_connection.id
  remote_uri = var.github_repository_remote_uri
}

resource "google_cloudbuild_trigger" "github_trigger" {
    location = var.region
  project = var.project_id
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^main$"
    }
  }
  filename = "my-app/cloudbuild.yaml"
}