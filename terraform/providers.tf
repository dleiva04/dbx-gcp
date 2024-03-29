terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket-dbx"
    prefix = "terraform/state"
  }
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.google_project
}

# provider "databricks" {
#   account_id         = var.databricks_account_id
#   host               = "https://accounts.gcp.databricks.com"
#   # google_service_account = "" only impersonated SA
# }

provider "databricks" {
  account_id         = var.databricks_account_id
  host               = "https://accounts.gcp.databricks.com"
  google_credentials = var.google_creds
}

resource "random_string" "suffix" {
  special = false
  upper   = false
  length  = 6
}
