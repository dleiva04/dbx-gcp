terraform {
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
  project = ""
}

provider "databricks" {
  host                   = "https://accounts.gcp.databricks.com"
  google_service_account = "sa-gh-actions@fe-dev-sandbox.iam.gserviceaccount.com"
}

resource "databricks_user" "gcp-user" {
  user_name = "gcp-actions@databricks.com"
}

# module "examples_gcp-workspace-byovpc" {
#   source                = "databricks/examples/databricks//modules/gcp-workspace-byovpc"
#   version               = "0.2.16"
#   databricks_account_id = ""
#   delegate_from         = []
#   google_project        = ""
#   google_region         = ""
#   prefix                = ""
#   nat_name              = ""
#   router_name           = ""
#   subnet_name           = ""
#   subnet_ip_cidr_range  = ""
#   pod_ip_cidr_range     = ""
#   svc_ip_cidr_range     = ""

#   providers = {
#     databricks = databricks,
#     google     = google
#   }
# }

# assign a metastore
