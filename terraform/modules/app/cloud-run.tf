resource "google_cloud_run_v2_service" "app" {
  name     = "app"
  location = var.region

  template {
    timeout                          = 300
    max_instance_request_concurrency = 50

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

    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }

    volumes {
      name = "cloudsql-instance-connection"
      cloud_sql_instance {
        instances = [var.db_connection_name]
      }
    }
  }
}