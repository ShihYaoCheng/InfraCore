﻿module "resources" {
  source  = "../../../Modules/Resources/0.1.0"

  # https://cloud.google.com/storage/docs/troubleshooting#bucket-name-conflict
  # The GCS bucket name must be unique in the entire GCP. If you have a 409 conflict error
  # which means the bucket name has been used by another user, you should use another name.
  ProjectName = "cqi-sk-prod-asia-east1"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
}