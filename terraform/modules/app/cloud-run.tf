resource "google_cloud_run_service" "app" {
  name                       = "app"
  location                   = var.region
  autogenerate_revision_name = true

  template {
    spec {
      timeout_seconds       = 300
      container_concurrency = 50
      containers {
        image = var.image_name
        resources {
          limits = {
            "memory" : "256Mi",
            "cpu" : "1"
          }
        }
        ports {
          container_port = 3000
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "5"
        "run.googleapis.com/cloudsql-instances" = var.db_connection_name
      }
    }
  }

  
}