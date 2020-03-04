/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_compute_network" "broker" {
  name                    = var.name
  auto_create_subnetworks = false
  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_subnetwork" "broker-west" {
  name          = "${var.name}-west"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-west1"
  network       = google_compute_network.broker.self_link

  secondary_ip_range = [
    {
      range_name    = "${var.name}-pods"
      ip_cidr_range = "172.16.0.0/16"
    },
    {
      range_name    = "${var.name}-pods-staging"
      ip_cidr_range = "172.17.0.0/16"
    },
    {
      range_name    = "${var.name}-pods-dev"
      ip_cidr_range = "172.18.0.0/16"
    },
    {
      range_name    = "${var.name}-services"
      ip_cidr_range = "192.168.0.0/24"
    },
    {
      range_name    = "${var.name}-services-staging"
      ip_cidr_range = "192.168.1.0/24"
    },
    {
      range_name    = "${var.name}-services-dev"
      ip_cidr_range = "192.168.2.0/24"
    }
  ]
}

resource "google_compute_firewall" "turn" {
  name = "k8s-fw-gke-turn"
  network = replace(
    google_compute_network.broker.self_link,
    "https://www.googleapis.com/compute/v1/",
    "",
  )

  allow {
    protocol = "tcp"
    ports    = ["3478", "25000-25100"]
  }

  allow {
    protocol = "udp"
    ports    = ["3478", "25000-25100"]
  }

  target_tags   = ["gke-turn"]
  source_ranges = ["0.0.0.0/0"]
}