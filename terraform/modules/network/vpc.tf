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

resource "google_project_service" "service_networking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.environment}-${var.project}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_access_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
  depends_on = [
    google_project_service.service_networking,
    google_compute_network.vpc
  ]
}
