provider "google" {
  project = "eu-energy-proj"
  credentials = file("./service-account.json")
}

resource "google_storage_bucket" "energy_data" {
  name     = "energy-data-bucket89"
  location = "US"
}

resource "google_bigquery_dataset" "energy_dataset" {
  dataset_id = "owid_energy"
  project    = "eu-energy-proj"
  location   = "US"
}

resource "google_bigquery_table" "energy_table" {
  dataset_id = google_bigquery_dataset.energy_dataset.dataset_id
  table_id   = "energy_data"
}