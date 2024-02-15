resource "google_cloud_run_v2_service" "app" {
  name     = "app"
  location = var.region

  template {
    timeout                          = "300s"
    max_instance_request_concurrency = 50

    containers {
      image = var.image_name
      resources {
        limits = {
          "memory" : "512Mi",
          "cpu" : "1"
        }
      }
      ports {
        container_port = 3000
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.db_connection_name]
      }
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].containers[0].image,
    ]
  }
}

