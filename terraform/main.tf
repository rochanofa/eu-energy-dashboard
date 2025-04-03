terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  project = "eu-energy-proj"
  credentials = file("./service-account.json")
}

resource "google_storage_bucket" "energy_data" {
  name     = "energy-data-bucket01"
  location = "US"
}

resource "google_bigquery_dataset" "energy_dataset" {
  dataset_id = "euenergy"  
  project    = "eu-energy-proj"
  location   = "US"
}

resource "google_bigquery_table" "energy_table" {
  dataset_id = google_bigquery_dataset.energy_dataset.dataset_id  
  table_id   = "energy_data"
}