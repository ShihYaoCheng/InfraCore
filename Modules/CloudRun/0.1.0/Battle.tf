# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service#metadata
data "kubernetes_service" "user" {
  count = 0
  metadata {
    name = "user"
    namespace = "user"
  }
}

# https://registry.terraform.io/modules/GoogleCloudPlatform/cloud-run/google/latest
module "cloud-run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.3.0"
  
  project_id = var.GCPProjectID
  image = var.CloudRunImage
  location = var.GCPRegion

  service_name = var.CloudRunName
  
  # https://cloud.google.com/run/docs/reference/rpc/google.cloud.run.v1#revisiontemplate
  template_annotations = {
    "autoscaling.knative.dev/minScale" = var.CloudRunMinScale
    "autoscaling.knative.dev/maxScale" = var.CloudRunMaxScale
#    "run.googleapis.com/vpc-access-connector" = one(module.serverless-connector.connector_ids)
#    "run.googleapis.com/vpc-access-egress" = "all-traffic"
  }
  
#  env_vars = [
#    {
#      name: "ExternalServers__User"
#      value: data.kubernetes_service.user.status.0.load_balancer.0.ingress.0.ip
#    }
#  ]
  
  limits = {
    memory: "512Mi"
    cpu: "1000m"
  }
  
  ports = {
    "name": "http1",
    "port": 8080
  }
}

data "google_iam_policy" "noAuth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noAuth" {
  project     = var.GCPProjectID
  location    = var.GCPRegion
  service     = module.cloud-run.service_name

  policy_data = data.google_iam_policy.noAuth.policy_data
}

