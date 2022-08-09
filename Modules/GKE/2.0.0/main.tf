data "http" "MyIP" {
  url = "http://ipv4.icanhazip.com"
}

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~>22.0.0"

  # Required.
  project_id = var.GCPProjectID
  name       = var.ProjectName
  region     = var.GCPRegion
  
  # Optional
  cluster_resource_labels = var.GKE-Labels

  network           = var.ProjectName
  subnetwork        = var.ProjectName
  # module.vpc.subnets_secondary_ranges[x], access subnet.
  # module.vpc.subnets_secondary_ranges[x][x], access subnet - secondary.
  ip_range_pods     = ""
  ip_range_services = ""

  create_service_account = false // avoid ImagePullBack.

  release_channel    = null // null(default), UNSPECIFIED, RAPID, REGULAR, STABLE.
#  kubernetes_version = "1.24.2-gke.1900"
  kubernetes_version = "1.23.8-gke.1900"
#  kubernetes_version = "1.23.6-gke.2200"
#  kubernetes_version = "1.23.5-gke.1501"
#  kubernetes_version = "1.22.8-gke.200"

  # Optional.
  #  regional = var.GKERegional # Default = true
  regional = false
  zones    = var.GKE-Zones

  initial_node_count       = 0 // default: 0
  remove_default_node_pool = false // default: false

  enable_vertical_pod_autoscaling    = true
  horizontal_pod_autoscaling         = true
  # https://cloud.google.com/binary-authorization
  enable_binary_authorization        = true
  enable_network_egress_export       = true
  enable_resource_consumption_export = true
  enable_shielded_nodes              = true
  network_policy                     = true

  maintenance_start_time = "14:00" # UTC.

  # https://cloud.google.com/kubernetes-engine/docs/how-to/authorized-networks
  # https://avd.aquasec.com/misconfig/google/gke/avd-gcp-0061/
  master_authorized_networks = [
    {
      display_name = "Terraform"
      cidr_block = "${chomp(data.http.MyIP.body)}/32"
    }
  ]


  # It always has a scaling issue when I turn on autoscaling functionality in the Kubernetes.
  # It wastes much time to find the root cause. Unfortunately, I choose to abandon this issue
  # right now and do it later. I will set a fixed number for node count to avoid this
  # issue right now.

  # ClusterAutoscaling contains global, per-cluster information required by
  # Cluster Autoscaler to automatically adjust the size of the cluster and
  # create/delete [node pools] based on the current needs.
  # https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling
#  cluster_autoscaling = {
#    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#nested_cluster_autoscaling
#    # (Required) Whether node auto-provisioning is enabled. Resource limits for cpu and memory must be defined to enable node auto-provisioning.
#    # Autoscaling does not seem to be working properly. When I built a new Kubernetes, the Kubernetes resource more than Autoscaling configuration.
#    enabled       = false
#    min_cpu_cores = var.GKE-AutoScaling-MinCPU
#    max_cpu_cores = var.GKE-AutoScaling-MaxCPU
#    min_memory_gb = var.GKE-AutoScaling-MinMemoryGB
#    max_memory_gb = var.GKE-AutoScaling-MaxMemoryGB
#    gpu_resources = []
#  }

  # https://avd.aquasec.com/misconfig/google/gke/avd-gcp-0057/
  node_metadata = "GKE_METADATA_SERVER"

  node_pools_tags = {
    all = ["gke-worker-node"]
  }

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



