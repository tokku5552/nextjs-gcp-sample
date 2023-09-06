resource "google_compute_network" "vpc" {
  name = "${var.environment}-${var.project}-vpc"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "private" {
  name          = "${var.environment}-${var.project}-private-subnet"
  ip_cidr_range = "10.0.21.0/24"
  network       = google_compute_network.vpc.id
}