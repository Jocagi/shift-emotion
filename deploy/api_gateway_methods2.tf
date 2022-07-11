## [GET] /hello - Lambda function hello
resource "aws_api_gateway_method" "hello_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.hello.id
  api_key_required = false
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "hello_get_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = "GET"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_hello" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.hello.id
  http_method             = aws_api_gateway_method.hello_get.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.hello.invoke_arn

  type = "AWS"
  /*
  content_handling     = "CONVERT_TO_TEXT"
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  */
}

resource "aws_api_gateway_integration_response" "lambda_hello" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_get.http_method
  status_code = aws_api_gateway_method_response.hello_get_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_hello
  ]
}

resource "aws_lambda_permission" "hello_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.hello_get.http_method}/${aws_api_gateway_resource.hello.path_part}"
}

## [OPTIONS] /hello - CORS
resource "aws_api_gateway_method" "hello_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.hello.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.hello_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

## [POST] /register - Lambda function register
resource "aws_api_gateway_method" "register_post" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.register.id
  api_key_required = false
  http_method      = "POST"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "register_post_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.register.id
  http_method = "POST"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.register_post]
}

resource "aws_api_gateway_integration" "lambda_register" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.register.id
  http_method             = aws_api_gateway_method.register_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.register.invoke_arn
}

resource "aws_api_gateway_integration_response" "lambda_register" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.register.id
  http_method = aws_api_gateway_method.register_post.http_method
  status_code = aws_api_gateway_method_response.register_post_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_register
  ]
}

resource "aws_lambda_permission" "register_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.register.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.register_post.http_method}/${aws_api_gateway_resource.register.path_part}"
}

## [OPTIONS] /register - CORS
resource "aws_api_gateway_method" "register_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.register.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "register_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.register.id
  http_method = aws_api_gateway_method.register_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}


## [POST] /login - Lambda function login
resource "aws_api_gateway_method" "login_post" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.login.id
  api_key_required = false
  http_method      = "POST"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "login_post_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = "POST"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.login_post]
}

resource "aws_api_gateway_integration" "lambda_login" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.login_post.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.login.invoke_arn

  type             = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_login" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.login_post.http_method
  status_code = aws_api_gateway_method_response.login_post_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_login
  ]
}

resource "aws_lambda_permission" "login_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.login.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.login_post.http_method}/${aws_api_gateway_resource.login.path_part}"
}

## [OPTIONS] /login - CORS
resource "aws_api_gateway_method" "login_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "login_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.login_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

## [GET] /profile - Lambda function profile
resource "aws_api_gateway_method" "profile_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.profile.id
  api_key_required = false
  http_method      = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.verify-token.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method_response" "profile_get_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.profile.id
  http_method = "GET"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.profile_get]
}

resource "aws_api_gateway_integration" "lambda_profile" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.profile.id
  http_method             = aws_api_gateway_method.profile_get.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.profile.invoke_arn
 
  type                 = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_profile" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.profile.id
  http_method = aws_api_gateway_method.profile_get.http_method
  status_code = aws_api_gateway_method_response.profile_get_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_profile
  ]
}

resource "aws_lambda_permission" "profile_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.profile.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.profile_get.http_method}/${aws_api_gateway_resource.profile.path_part}"
}

## [OPTIONS] /profile - CORS
resource "aws_api_gateway_method" "profile_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.profile.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "profile_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.profile.id
  http_method = aws_api_gateway_method.profile_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}
