module "app" {
  source      = "../../../../modules/app"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment
  project     = var.project

  image_name         = var.image_name
  db_connection_name = data.terraform_remote_state.database.outputs.db_connection_name
}