resource "aws_ssm_parameter" "bucket" {
  name        = "/${var.environment}/${var.ssm_path}"
  description = "Source file download bucket name for serverless lambda functions."
  type        = "String"
  value       = var.bucket_id
}
