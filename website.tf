resource "google_cloud_run_service" "website" {
  name     = "website"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/terraforming-with-freeman/web:v0.0.1"
        ports {
          name           = "http"
          protocol       = "http"
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_policy" "noauth-website" {
  location = google_cloud_run_service.website.location
  project  = google_cloud_run_service.website.project
  service  = google_cloud_run_service.website.name

  policy_data = data.google_iam_policy.noauth.policy_data
}