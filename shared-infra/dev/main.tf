terraform {
  backend "s3" {
    bucket = "test.terraform.state.config.fi.test.bucke"
    key    = "test/state/serverless-shared-infra-config" # Format: ENVIRONMENT/state/PROJECT
    region = "eu-west-1"
    # dynamodb_table = "test-terraform-lock-shared"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Timestamp   = timestamp()
    }
  }
}

module "ssm" {
  source      = "../modules/ssm"
  environment = var.environment
  bucket_id   = module.s3.bucket_id
  ssm_path    = var.ssm_path

  depends_on = [
    module.s3
  ]
}

module "s3" {
  source      = "../modules/s3"
  environment = var.environment
}

