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
    "roles/iam.serviceAccountUser"
  ])
  role    = each.key
  member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  project = var.project_id
}

# resource "google_service_account_iam_binding" "name" {
#   # service_account_id = "projects/${var.project_id}/serviceAccounts/${var.project_number}-run@developer.gserviceaccount.com"
#   service_account_id = google_cloud_run_v2_service.app.template[0].service_account
#   role = "roles/iam.serviceAccountUser"

#   members = [
#     "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
#   ]
# }

# resource "google_cloud_run_service_iam_member" "cloudbuild_iam" {
#   location = var.region
#   project = var.project_id
#   service = google_cloud_run_v2_service.app.name
#   role    = "roles/run.admin"
#   member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
# }

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