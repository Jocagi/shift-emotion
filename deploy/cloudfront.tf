// Website

resource "aws_cloudfront_origin_access_identity" "OAI" {
  comment = "OAI for cloudfront to website s3"
}
resource "aws_cloudfront_distribution" "cloudfront" {

  enabled             = true
  default_root_object = "index.html"
  web_acl_id          = aws_wafv2_web_acl.waf.arn

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website.bucket

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.OAI.id}"
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.website.bucket
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  //400
  custom_error_response {

    error_code            = 400
    response_code         = 400
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //403
  custom_error_response {

    error_code            = 403
    response_code         = 403
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //404
  custom_error_response {

    error_code            = 404
    response_code         = 404
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //400
  custom_error_response {

    error_code            = 400
    response_code         = 400
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //405
  custom_error_response {

    error_code            = 405
    response_code         = 405
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //414
  custom_error_response {

    error_code            = 414
    response_code         = 414
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //416
  custom_error_response {

    error_code            = 416
    response_code         = 416
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //500
  custom_error_response {

    error_code            = 500
    response_code         = 500
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //501
  custom_error_response {

    error_code            = 501
    response_code         = 501
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //502
  custom_error_response {

    error_code            = 502
    response_code         = 502
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //503
  custom_error_response {

    error_code            = 503
    response_code         = 503
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }

  //504
  custom_error_response {

    error_code            = 504
    response_code         = 504
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
  }
}