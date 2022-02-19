resource "aws_s3_bucket" "movie_data_source_file_bucket" {
  bucket = "${var.environment}-movie-source-data-bucket"
}

resource "aws_s3_bucket_versioning" "movie_data_source_file_bucket_versioning" {
  bucket = aws_s3_bucket.movie_data_source_file_bucket.id

  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_acl" "movie_data_source_file_bucket_versioning_acl" {
  bucket = aws_s3_bucket.movie_data_source_file_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "movie_data_source_file_Log_bucket" {
  bucket = "${var.environment}-movie-source-data-bucket-tf-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.movie_data_source_file_Log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.movie_data_source_file_bucket.id

  target_bucket = aws_s3_bucket.movie_data_source_file_Log_bucket.id
  target_prefix = "log/"
}
