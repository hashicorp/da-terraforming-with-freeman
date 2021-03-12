resource "google_storage_bucket_object" "website" {
  name   = "index.htm"
  content = <<EOF
<!doctype html>
<html>
    <head>
        <title>Little Troublemakers</title>
    </head>
    <body>
        <ul>
            <li><img src="frank.jpg"/></li>
            <li><img src="nori.jpg"/></li>
        </ul>
    </body>
</html>
EOF
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_object_access_control" "website_public" {
  object = google_storage_bucket_object.website.output_name
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}