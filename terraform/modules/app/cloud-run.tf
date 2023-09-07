resource "google_cloud_run_service" "app" {
  name                       = "sample-api"
  location                   = var.region
  autogenerate_revision_name = true 

  template {
    spec {
      timeout_seconds       = 300
      container_concurrency = 50
      containers {
        image = "us.gcr.io/${var.project_id}/sample-api" # すでにimageがアップロード済みでないといけない
        resources {
          limits = {
            "memory" : "256Mi",
            "cpu" : "1"
          }
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "5"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].metadata[0].labels,
      template[0].spec[0].containers["image"]
    ]
  }
}