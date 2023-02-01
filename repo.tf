# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "google_sourcerepo_repository" "website_repo" {
  name = "website"
}

output "website_repo_url" {
  value = google_sourcerepo_repository.website_repo.url
}

