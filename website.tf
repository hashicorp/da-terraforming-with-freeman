resource "google_storage_bucket_object" "website" {
  name    = "index.htm"
  source = "assets/index.htm"
  bucket  = google_storage_bucket.bucket.name
}

resource "google_storage_object_access_control" "website_public" {
  object = google_storage_bucket_object.website.output_name
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}