resource "databricks_mws_networks" "this" {
  provider     = databricks
  account_id   = var.databricks_account_id
  network_name = "test-demo-${random_string.suffix.result}"
  gcp_network_info {
    network_project_id    = var.google_project
    vpc_id                = google_compute_network.vpc.name
    subnet_id             = google_compute_subnetwork.subnet_secondary_ranges.name
    subnet_region         = google_compute_subnetwork.subnet_secondary_ranges.region
    pod_ip_range_name     = "pods"
    service_ip_range_name = "svc"
  }
}

resource "databricks_mws_workspaces" "this" {
  provider       = databricks
  account_id     = var.databricks_account_id
  workspace_name = "tf-demo-test-${random_string.suffix.result}"
  location       = google_compute_subnetwork.subnet_secondary_ranges.region
  cloud_resource_container {
    gcp {
      project_id = var.google_project
    }
  }

  network_id = databricks_mws_networks.this.network_id

  # this makes sure that the NAT is created for outbound traffic before creating the workspace
  depends_on = [google_compute_router_nat.nat]
}

resource "databricks_metastore_assignment" "this" {
  metastore_id = "aa75beb2-fa78-4117-9f14-06a10371db62"
  workspace_id = databricks_mws_workspaces.this.workspace_id
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}
