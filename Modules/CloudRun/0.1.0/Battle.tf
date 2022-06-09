resource "google_cloud_run_service" "battle" {
  name     = "test"
  location = var.GCPRegion

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale": 1
        "autoscaling.knative.dev/maxScale": 1
      }
    }
    spec {
      containers {
        image = "gcr.io/stellar-38931/sk-battle:sre-5878b06e"
        ports {
          name = "http1"
          protocol = "TCP"
          container_port = 8080
        }
        resources {
          limits = {
            memory: "900Mi"
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

