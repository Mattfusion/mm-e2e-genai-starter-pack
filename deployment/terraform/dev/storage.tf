# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_storage_bucket" "logs_data_bucket" {
  name                        = "${var.dev_project_id}-logs-data"
  location                    = var.region
  project                     = var.dev_project_id
  uniform_bucket_level_access = true

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }

  # Use this block to create the bucket only if it doesn't exist
  count      = length(data.google_storage_bucket.existing_bucket) > 0 ? 0 : 1
  depends_on = [resource.google_project_service.services]
}

data "google_storage_bucket" "existing_bucket" {
  name    = "${var.dev_project_id}-logs-data"
  project = var.dev_project_id

  # Capture the error if the bucket doesn't exist
  count      = can(data.google_storage_bucket.existing_bucket[0]) ? 1 : 0
  depends_on = [resource.google_project_service.services]
}
