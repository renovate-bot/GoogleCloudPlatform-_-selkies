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

output "project_id" {
  description = "Project ID"
  value       = var.project_id
}

output "name" {
  description = "Name of infrastructure deployment"
  value       = var.name
}

output "us-west1-gke-version" {
  value = data.google_container_engine_versions.us-west1.latest_master_version
}

output "cloud-ep-endpoint" {
  description = "Cloud Endpoint DNS"
  value       = module.cloud-ep-dns.endpoint
}

output "cloud-dns" {
  description = "Cloud DNS Endpoint, if enabled."
  // TODO
  value = ""
}

output "static-ip-name" {
  description = "Name of static external IP for ingress"
  value       = google_compute_global_address.ingress.name
}

output "static-ip-address" {
  description = "Address of static external IP for ingress"
  value       = google_compute_global_address.ingress.address
}

output "node-service-account" {
  description = "Service account used by the node"
  value       = google_service_account.cluster_service_account.email
}

output "broker-west-cluster-name" {
  description = "Name of cluster"
  value       = module.broker-west.name
}

output "broker-west-cluster-location" {
  description = "Region of cluster"
  value       = module.broker-west.region
}