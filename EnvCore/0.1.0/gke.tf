
# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
#  version = "~>18.0.0"
  version = "~>19.0.0"

  // Required.
  project_id = var.GCPProjectID
  name = local.GKEName
  region = var.GCPRegion

  network = module.vpc.network_name
  subnetwork = module.vpc.subnets_names[0]
  // module.vpc.subnets_secondary_ranges[x], access subnet.
  // module.vpc.subnets_secondary_ranges[x][x], access subnet - secondary.
  ip_range_pods = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services = module.vpc.subnets_secondary_ranges[0][1].range_name

  create_service_account = false // avoid ImagePullBack.

  release_channel = null // null(default), UNSPECIFIED, RAPID, REGULAR, STABLE.
  kubernetes_version = "1.22.6-gke.300"

  // Optional.
  regional = var.GKERegional # Default = true
  zones = var.GKEZones
#  zones = ["asia-east1-b"]

  initial_node_count = 0 // default: 0
  remove_default_node_pool = false // default: false

  enable_vertical_pod_autoscaling = true
  enable_binary_authorization = true
  enable_network_egress_export = true
  enable_resource_consumption_export = true
  enable_shielded_nodes = true
  horizontal_pod_autoscaling = true
  network_policy = true

  maintenance_start_time = "14:00" # UTC.

#  cluster_autoscaling = {
#    enabled = true
#    min_cpu_cores = 0
#    max_cpu_cores = 20
#    min_memory_gb = 0
#    max_memory_gb = 20
#    gpu_resources = []
#  }

  node_metadata = "UNSPECIFIED"
  node_pools = [
    {
      name = "pool-e2-standard-4"
      machine_type = "e2-standard-4"

#      autoscaling = false # Default = true
#      node_count = 0

      autoscaling = true # Default = true
      min_count = var.GKEMinNodeCount
      max_count = var.GKEMaxNodeCount

      disk_size_gb = 20
      disk_type = "pd-standard"

      auto_repair = true
      auto_upgrade = true

      enable_secure_boot = true
    },
  ]
}


