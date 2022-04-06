# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~>20.0.0"

  // Required.
  project_id = var.GCPProjectID
  name       = "sk-sre"
  region     = var.GCPRegion

  network           = "sk-sre"
  subnetwork        = "sk-sre"
  // module.vpc.subnets_secondary_ranges[x], access subnet.
  // module.vpc.subnets_secondary_ranges[x][x], access subnet - secondary.
  ip_range_pods     = ""
  ip_range_services = ""

  create_service_account = false // avoid ImagePullBack.

  release_channel    = null // null(default), UNSPECIFIED, RAPID, REGULAR, STABLE.
  #  kubernetes_version = "1.22.6-gke.300"
  kubernetes_version = "1.22.7-gke.1500"

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
    enabled       = false
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

# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "gke-gcs-bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  name       = "sk-sre"
  project_id = var.GCPProjectID

  # https://cloud.google.com/storage/docs/locations#available-locations
  location   = var.GCPRegion

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  # When deleting a bucket, this boolean option will delete all contained objects.
  # If false, Terraform will fail to delete buckets which contain objects.
  force_destroy = true
}

resource "google_storage_bucket_object" "gke-api" {
  bucket = module.gke-gcs-bucket.bucket.name
  name   = "api"
  content = module.gke.endpoint
}

resource "google_storage_bucket_object" "gke-ca" {
  bucket = module.gke-gcs-bucket.bucket.name
  name   = "ca"
  content = module.gke.ca_certificate
}
