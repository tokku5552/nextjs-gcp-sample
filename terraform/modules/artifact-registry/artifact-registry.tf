resource "google_artifact_registry_repository" "app" {
  project       = var.project_id
  location      = var.region
  repository_id = "${var.environment}-${var.project}-app"
  format        = "DOCKER"
}