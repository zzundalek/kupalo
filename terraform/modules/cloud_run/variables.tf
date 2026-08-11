variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region where the cloud run will be created"
}

variable "name" {
  type        = string
  description = "Cloud Run Service name"
}
