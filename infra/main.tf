# Bucket to store website

resource "google_storage_bucket" "website" {
  name = "example-website-by-wilfried"
  location = "US"
}

# Make new objects public which allow objet to the bucket to be publicon internet
resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_src.name
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"
}

# upload index.html to bucket
resource "google_storage_bucket_object" "static_site_src" {
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name
}

# Reserve an external IP
resource "google_compute_global_address" "website_ip" {
  provider = google
  name     = "website-lb-ip"
}