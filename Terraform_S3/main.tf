# resource "aws_s3_bucket" "terraform_s3_bucket" {
#   bucket = var.bucket
#   acl    = var.acl

#   versioning {
#     enabled = var.versioning_enabled
#   }

#   tags = {
#     Name        = var.tag_name
#     Environment = var.environment
#   }
# }
resource "aws_s3_bucket" "terraform_s3_bucket" {
  bucket = var.bucket_name
  acl    = var.acl
}

# resource "aws_s3_bucket_acl" "terraform_s3_bucket_acl" {
#   bucket = aws_s3_bucket.terraform_s3_bucket.id
#   acl    = var.acl
# }

# resource "aws_s3_bucket_versioning" "versioning_example" {
#   bucket = aws_s3_bucket.terraform_s3_bucket.id
#   versioning_configuration {
#     status = var.versioning_configuration_status
#   }
# }