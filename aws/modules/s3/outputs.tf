# Output attributes of the S3 bucket
# AWS s3 bucket id
output "bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "Bucket Name (aka ID)"
}

# AWS s3 bucket arn
output "bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "The arn of the bucket will be in format arn:aws:s3::bucketname"
}


