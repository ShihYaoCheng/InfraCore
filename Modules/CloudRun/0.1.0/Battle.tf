resource "google_cloud_run_service" "battle" {
  name     = var.CloudRunName
  location = var.GCPRegion

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = var.CloudRunMinScale
        "autoscaling.knative.dev/maxScale" = var.CloudRunMaxScale
#        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.connector.name
      }
    }
    spec {
      containers {
        image = var.CloudRunImage
        ports {
          name = "http1"
#          protocol = "TCP"
          container_port = 8080
        }
        resources {
          limits = {
            memory: "512Mi"
            cpu: "1000m"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
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
  service     = google_cloud_run_service.battle.name

  policy_data = data.google_iam_policy.noAuth.policy_data
}

