data "http" "MyIP" {
  url = "http://ipv4.icanhazip.com"
}

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/safer-cluster
# https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/v22.1.0/modules/safer-cluster
module "GKE-SafeCluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/safer-cluster"
  version = "22.1.0"

  name              = var.ProjectName
  network           = var.ProjectName
  project_id        = var.GCPProjectID
  region            = var.GCPRegion
  subnetwork        = var.ProjectName
  ip_range_pods     = ""
  ip_range_services = ""

  regional = false # default = true, control plane run on multiple zones.
  zones = [var.GCPZone] # worker node run on multiple zones.
  release_channel = null
  kubernetes_version = "1.23.7-gke.1400"
  maintenance_start_time = "16:00" # UTC.

  disable_default_snat = false
  enable_private_endpoint = false
  enable_intranode_visibility = true
  enable_pod_security_policy = false
  enable_network_egress_export = true
  enable_resource_consumption_export = true
  enable_shielded_nodes = true
  enable_vertical_pod_autoscaling = false
  filestore_csi_driver = false
  http_load_balancing = true

  cluster_resource_labels = {"name"="sre"}
  description = "just for test"
  

  # https://cloud.google.com/kubernetes-engine/docs/how-to/authorized-networks
  # https://avd.aquasec.com/misconfig/google/gke/avd-gcp-0061/
  master_authorized_networks = [
    {
      display_name = "Terraform"
      cidr_block = "${chomp(data.http.MyIP.body)}/32"
    }
  ]

  node_pools_tags = {
    all = ["gke-worker-node"]
  }

  initial_node_count = 0
  node_pools    = [
    {
      name         = "pool-e2-standard-2"
      # https://cloud.google.com/compute/docs/general-purpose-machines#e2_limitations
      # e2-standard-2, CPU=2, Memory=8G
      # e2-standard-4, CPU=4, Memory=16G
      machine_type = "e2-standard-2"

      # Configuration required by cluster autoscaler to adjust the size of the node pool to the current cluster usage
      autoscaling = var.GKE-NodePoolScale-2C8G # Default = true
      # It needs four vCPU resources at least now when terraform creates all resources in Kubernetes.
      node_count  = var.GKE-NodeNum-2C8G
      # Minimum number of nodes in the NodePool. Must be >=0 and <= max_count. Should be used when autoscaling is true
      min_count = 0 # default: 1.
      # Maximum number of nodes in the NodePool. Must be >= min_count
      max_count = var.GKE-MaxNum-2C8G # default: 100.

      disk_size_gb = 60
      disk_type    = "pd-standard"

      auto_repair  = true
      # Whether the nodes will be automatically upgraded
      auto_upgrade = true

      enable_secure_boot = true

      spot = var.GKE-CheapNodePool-2C8G
    },
    {
      name         = "pool-e2-standard-4"
      # https://cloud.google.com/compute/docs/general-purpose-machines#e2_limitations
      # e2-standard-2, CPU=2, Memory=8G
      # e2-standard-4, CPU=4, Memory=16G
      machine_type = "e2-standard-4"

      autoscaling = var.GKE-NodePoolScale-4C16G # Default = true
      # It needs four vCPU resources at least now when terraform creates all resources in Kubernetes.
      node_count  = var.GKE-NodeNum-4C16G

      # Minimum number of nodes in the NodePool. Must be >=0 and <= max_count. Should be used when autoscaling is true
      min_count = 0 # default: 1.
      # Maximum number of nodes in the NodePool. Must be >= min_count
      max_count = var.GKE-MaxNum-4C16G # default: 100.

      disk_size_gb = 60
      disk_type    = "pd-standard"

      auto_repair  = true
      auto_upgrade = true

      enable_secure_boot = true

      spot = var.GKE-CheapNodePool-4C16G
    }
  ]
}


