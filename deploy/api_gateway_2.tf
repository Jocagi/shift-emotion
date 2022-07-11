// API Gateway configuration
resource "aws_api_gateway_rest_api" "api_gateway_2" {

  name = "${var.app_name}-api-rest-2"
  description = "API Gateway de ${var.app_name} - 2"

  binary_media_types = [ 
    "image/jpeg",
    "image/png"
  ]
}

resource "aws_api_gateway_deployment" "api_deploy_2" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  stage_description = "Deployed at ${timestamp()}"

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway_2.body))
  }

  depends_on = [
    aws_api_gateway_integration.lambda_hello,
    aws_api_gateway_integration.hello_cors,
    aws_api_gateway_integration.lambda_register,
    aws_api_gateway_integration.register_cors,
    aws_api_gateway_integration.lambda_login,
    aws_api_gateway_integration.login_cors,
    aws_api_gateway_integration.lambda_profile,
    aws_api_gateway_integration.profile_cors
  ]

}

resource "aws_api_gateway_stage" "api_gw_stage_2" {

  deployment_id = aws_api_gateway_deployment.api_deploy_2.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_2.id
  stage_name    = "prod"
}

resource "aws_api_gateway_api_key" "api_key_2" {

  name = "${var.app_name}-prod-api-key-2"
}

resource "aws_api_gateway_usage_plan" "api_gw_usage_plan_2" {

  name = "${var.app_name}-prod-api-gw-usage-plan-2"

  api_stages {

    api_id = aws_api_gateway_rest_api.api_gateway_2.id
    stage  = aws_api_gateway_stage.api_gw_stage_2.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_api_key_2" {

  key_id        = aws_api_gateway_api_key.api_key_2.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api_gw_usage_plan_2.id
}

resource "aws_api_gateway_authorizer" "verify-token" {
  name                   = "verify-token"
  rest_api_id            = aws_api_gateway_rest_api.api_gateway_2.id
  authorizer_uri         = aws_lambda_function.authorize.invoke_arn
  authorizer_credentials = aws_iam_role.authorize_service.arn
}

// API Gateway Resources

# /hello
resource "aws_api_gateway_resource" "hello" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_2.root_resource_id
  path_part   = "hello"
}

# /register
resource "aws_api_gateway_resource" "register" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_2.root_resource_id
  path_part   = "register"
}

# /login
resource "aws_api_gateway_resource" "login" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_2.root_resource_id
  path_part   = "login"
}

# /profile
resource "aws_api_gateway_resource" "profile" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_2.root_resource_id
  path_part   = "profile"
}