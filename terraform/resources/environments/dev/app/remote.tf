data "terraform_remote_state" "database" {
  backend = "gcs"
  config = {
    bucket = "de6f0fe9cb3c1724-bucket-tfstate"
    prefix = "dev/database"
  }
}