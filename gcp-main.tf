# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
#criação de instância de banco de dados mysql
resource "google_sql_database_instance" "instance" {
  name             = "mysql-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

#criação do banco de dados
resource "google_sql_database" "database" {
  name     = "playlist"
  instance = google_sql_database_instance.instance.name
}

#criação repositório de imagens Docker
resource "google_artifact_registry_repository" "spotmusic" {
  location = var.region
  repository_id = "spotmusic"
  description = "Imagens Docker"
  format = "DOCKER"
}

#criação de usuário do banco de dados
resource "google_sql_user" "users" {
  name     = "playlist-user"
  instance = google_sql_database_instance.instance.name
  password = "12345"
}