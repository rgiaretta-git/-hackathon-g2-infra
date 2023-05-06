resource "google_artifact_registry_repository" "frontend" {
  location = var.region
  repository_id = "labdevops"
  description = "Imagens Docker"
  format = "DOCKER"
}

resource "google_artifact_registry_repository" "backend" {
  location = var.region
  repository_id = "labdevops"
  description = "Imagens Docker"
  format = "DOCKER"
}

resource "google_sql_database" "database" {
  name     = "playlist"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "mysql-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}