Origin Setup: The origin for this CloudFront distribution is an S3 bucket's static website endpoint (nandu-terraform-bucket353653.s3-website-us-east-1.amazonaws.com).
The custom_origin_config specifies HTTP and HTTPS settings, with an HTTP-only policy for fetching content.
Cache Behavior: CloudFront will allow HTTP and HTTPS requests and will only cache GET and HEAD methods. The cache will use the s3_site origin.
Root Object: The default root object served by CloudFront will be index.html, meaning this will be shown when users access the CloudFront distribution’s base URL.
This setup is suitable for serving static content (e.g., a static website hosted on S3) through CloudFront, with caching and HTTP/HTTPS configuration.