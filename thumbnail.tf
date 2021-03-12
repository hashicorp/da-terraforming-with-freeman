resource "google_storage_notification" "notification" {
  bucket         = google_storage_bucket.bucket.name
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.topic.id
  event_types    = ["OBJECT_FINALIZE"]
  custom_attributes = {
    width = "800"
  }
  depends_on = [google_pubsub_topic_iam_binding.binding]
}

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_pubsub_topic_iam_binding" "binding" {
  topic   = google_pubsub_topic.topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_pubsub_topic" "topic" {
  name = "default_topic"
}


resource "google_pubsub_subscription" "subscription" {
  name  = "subscription"
  topic = google_pubsub_topic.topic.name

  ack_deadline_seconds = 20

  push_config {
    push_endpoint = google_cloud_run_service.resize.status.0.url

    attributes = {
      x-goog-version = "v1"
    }
  }
}



resource "google_cloud_run_service" "resize" {
  name     = "resize"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/terraforming-with-freeman/resize:v0.0.1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}