
data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "de6f0fe9cb3c1724-bucket-tfstate"
    prefix = "network"
  }
}