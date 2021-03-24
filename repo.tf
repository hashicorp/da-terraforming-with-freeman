resource "google_sourcerepo_repository" "website_repo" {
  name = "website"
}

output "website_repo_url" {
  value = google_sourcerepo_repository.website_repo.url
}

resource "google_cloudbuild_trigger" "build" {
  trigger_template {
    branch_name = "master"
    repo_name   = google_sourcerepo_repository.website_repo.name
  }

  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [ "build", "-t", "gcr.io/${data.google_project.project.name}/web:v0.0.1", "." ]
    }

    source {
      repo_source {
        repo_name   = google_sourcerepo_repository.website_repo.name
      }
    }

    artifacts {
      images = ["gcr.io/${data.google_project.project.name}/web:v0.0.1"]
    }
  }
}