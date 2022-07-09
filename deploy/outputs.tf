/*
output "url_cloudFront" {

  value = aws_cloudfront_distribution.cloudfront.domain_name
}
*/
output "api_url" {

  value = aws_api_gateway_deployment.api_deploy.invoke_url
}

output "api_key" {

  value = nonsensitive(aws_api_gateway_api_key.api_key.value)
}