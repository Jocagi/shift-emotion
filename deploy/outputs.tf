/*
output "url_cloudFront" {

  value = aws_cloudfront_distribution.cloudfront.domain_name
}
*/
output "api_url_1" {

  value = "${aws_api_gateway_deployment.api_deploy.invoke_url}${aws_api_gateway_stage.api_gw_stage.stage_name}/"
}

output "api_url_2" {

  value = "${aws_api_gateway_deployment.api_deploy_2.invoke_url}${aws_api_gateway_stage.api_gw_stage_2.stage_name}/"
}

output "api_key" {

  value = nonsensitive(aws_api_gateway_api_key.api_key.value)
}