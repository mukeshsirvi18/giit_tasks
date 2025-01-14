#s3_main
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = var.bucket_name
  control_object_ownership = true  //permission > bucket ownership >Bucket owner enforced,  ensures that the bucket owner automatically owns all objects, regardless of the ACLs set by the object uploader.
  block_public_acls        = false //Block public access to buckets and objects granted through new access control lists (ACLs)
  block_public_policy      = false //Block public access to buckets and objects granted through new public bucket or access point policies
  ignore_public_acls       = false //Block public access to buckets and objects granted through any access control lists (ACLs)
  restrict_public_buckets  = false //Block public and cross-account access to buckets and objects through any public bucket or access point policies
  object_ownership         = "ObjectWriter" //>permission>object ownership>acl enabled, All objects in the bucket are owned by the bucket owner, regardless of who uploads them.
  acl                      = "public-read" //>permission>ACL>Everyone (public access) write(object).
  website = {
    index_document = "index.html"
  }
  versioning = {
    enabled = true
  }
}


resource "aws_s3_object" "object" {
  bucket       = var.bucket_name
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}
