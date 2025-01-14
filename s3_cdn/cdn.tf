#CDN
module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  #aliases = ["cdn.example.com"]

    
  origin = {

    something = {
      #domain_name = "${var.bucket_name}.s3-website-us-east-1.amazonaws.com"
      domain_name = "${var.bucket_name}.s3-website-us-east-1.amazonaws.com"
      origin_id   = "s3_site"   #identifier
      custom_origin_config = {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = ["TLSv1", "TLSv1.1","TLSv1.2"]
      }
    }
  }



  default_cache_behavior = {
    target_origin_id           = "s3_site"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
  }

  
  default_root_object = "index.html"


}