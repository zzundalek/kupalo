resource "google_cloud_run_v2_service" "backend" {
  name                = var.name
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  scaling {
    min_instance_count = 0
    max_instance_count = 1
  }

  # Ignore the image difference, so the image is not rewritten
  lifecycle {
    ignore_changes = [
      template[0].containers[0].image
    ]
  }

  template {
    containers {
      # Use an example image - as Cloud Run needs it
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      resources {
        cpu_idle = true
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      ports {
        container_port = 8080
      }
    }

    max_instance_request_concurrency = 80

    timeout = "300s"
  }
}
