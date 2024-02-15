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

resource "google_project_iam_member" "cloudbuild_iam" {
  for_each = toset([
    "roles/run.admin",
    "roles/iam.serviceAccountUser",
    "roles/secretmanager.secretAccessor",
  ])
  role    = each.key
  member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  project = var.project_id
}

resource "google_cloudbuild_trigger" "my-app_trigger" {
    location = var.region
  project = var.project_id
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      # branch = "^main$"
      branch = ".*"
    }
  }
  filename = "my-app/cloudbuild.yaml"

  substitutions = {
    _REGION                         = var.region
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project_id}/artifact-registry-nextjs-gcp-sample-app/console"
  }
}

resource "google_secret_manager_secret" "database_url" {
  secret_id = "DATABASE_URL"

  replication {
    auto {}
  }
}