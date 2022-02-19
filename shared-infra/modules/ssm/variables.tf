variable "environment" {
  type = string
}

variable "bucket_id" {
  type = string
}

variable "ssm_path" {
  type        = string
  description = "Path to the key to be saved."
}
