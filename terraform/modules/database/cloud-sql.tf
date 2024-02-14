resource "google_sql_database_instance" "db" {
  name                = "${var.environment}-${var.project}-db-instance"
  database_version    = "MYSQL_8_0"
  region              = var.region
  deletion_protection = false

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = "20"
    disk_type         = "PD_SSD"

    ip_configuration {
      private_network = var.vpc_private_link
      ipv4_enabled    = true                
    }

    # Only Standalone Instance for HA enabled
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
  }
}

resource "google_sql_database" "db" {
  name     = "${var.environment}-${var.project}-db"
  instance = google_sql_database_instance.db.name

}

resource "google_sql_user" "db" {
  name     = "${var.environment}-${var.project}-db-user"
  instance = google_sql_database_instance.db.name
  host     = "%"
  password = var.db_password
}