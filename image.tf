resource "google_storage_bucket_object" "frank_image" {
  name   = "frank.jpg"
  source = "assets/Frank.jpg"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_object_access_control" "frank_image_public" {
  object = google_storage_bucket_object.frank_image.output_name
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}

output "frank_url" {
  value = google_storage_bucket_object.frank_image.self_link
}