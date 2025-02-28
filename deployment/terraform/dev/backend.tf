terraform {
  backend "gcs" {
    bucket = "qwiklabs-gcp-02-f4aa291d4cb5-terraform-state"
    prefix = "dev"
  }
}
