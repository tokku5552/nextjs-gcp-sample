module "database" {
  source      = "../../../../modules/database"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment
  project     = var.project

  vpc_private_link = data.terraform_remote_state.network.outputs.private_network_link
  db_password      = var.db_password
}