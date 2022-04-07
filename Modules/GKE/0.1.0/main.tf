data "google_storage_bucket_object_content" "VPCName" {
  name   = "VPCName"
  bucket = "cqi-sk-sre"
}

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~>20.0.0"

  // Required.
  project_id = var.GCPProjectID
  name       = var.GKEName
  region     = var.GCPRegion

  network           = data.google_storage_bucket_object_content.VPCName.content
  subnetwork        = data.google_storage_bucket_object_content.VPCName.content
  // module.vpc.subnets_secondary_ranges[x], access subnet.
  // module.vpc.subnets_secondary_ranges[x][x], access subnet - secondary.
  ip_range_pods     = ""
  ip_range_services = ""

  create_service_account = false // avoid ImagePullBack.

  release_channel    = null // null(default), UNSPECIFIED, RAPID, REGULAR, STABLE.
  kubernetes_version = "1.22.7-gke.1500"
  #  kubernetes_version = "1.22.6-gke.300"

  // Optional.
  #  regional = var.GKERegional # Default = true
  regional = true
  zones = ["asia-east1-a"]

  initial_node_count       = 0 // default: 0
  remove_default_node_pool = false // default: false

  enable_vertical_pod_autoscaling    = true
  horizontal_pod_autoscaling         = true
  enable_binary_authorization        = true
  enable_network_egress_export       = true
  enable_resource_consumption_export = true
  enable_shielded_nodes              = true
  network_policy                     = true

  maintenance_start_time = "14:00" # UTC.

  # It always has a scaling issue when I turn on autoscaling functionality in the Kubernetes.
  # It wastes much time to find the root cause. Unfortunately, I choose to abandon this issue
  # right now and do it later. I will set a fixed number for node count to avoid this
  # issue right now.

  # ClusterAutoscaling contains global, per-cluster information required by
  # Cluster Autoscaler to automatically adjust the size of the cluster and
  # create/delete [node pools] based on the current needs.
  # https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling
  cluster_autoscaling = {
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#nested_cluster_autoscaling
    # (Required) Whether node auto-provisioning is enabled. Resource limits for cpu and memory must be defined to enable node auto-provisioning.
    enabled       = true
    min_cpu_cores = 2
    max_cpu_cores = 20
    min_memory_gb = 8
    max_memory_gb = 80
    gpu_resources = []
  }

  node_metadata = "UNSPECIFIED"
  node_pools    = [
    {
      name         = "pool-e2-standard-2"
      # https://cloud.google.com/compute/docs/general-purpose-machines#e2_limitations
      # e2-standard-2, CPU=2, Memory=8G
      # e2-standard-4, CPU=4, Memory=16G
      machine_type = "e2-standard-2"

      autoscaling = false # Default = true
      # It needs four vCPU resources at least now when terraform creates all resources in Kubernetes.
      node_count  = 2

      disk_size_gb = 15
      disk_type    = "pd-standard"

      auto_repair  = true
      auto_upgrade = true

      enable_secure_boot = true
    }
  ]
}

resource "google_storage_bucket_object" "gke-api" {
  bucket = var.GCSBucketName
  name   = "${var.GKEName}-api"
  content = module.gke.endpoint
}

resource "google_storage_bucket_object" "gke-ca" {
  bucket = var.GCSBucketName
  name   = "${var.GKEName}-ca"
  content = module.gke.ca_certificate
}

