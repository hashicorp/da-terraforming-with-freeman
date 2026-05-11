# Copyright IBM Corp. 2021, 2026

resource "google_sourcerepo_repository" "website_repo" {
  name = "website"
}

output "website_repo_url" {
  value = google_sourcerepo_repository.website_repo.url
}

