module "app" {
  source      = "../../../../modules/app"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment
  project     = var.project

  image_name         = var.image_name
  
  project_number = var.project_number
  db_connection_name = data.terraform_remote_state.database.outputs.db_connection_name
  github_app_installation_id = var.github_app_installation_id
  github_oauth_token_secret_version = var.github_oauth_token_secret_version
  github_repository_remote_uri = "https://github.com/tokku5552/nextjs-gcp-sample.git"
}