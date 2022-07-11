## [OPTIONS] /history - CORS
resource "aws_api_gateway_method" "history_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id   = aws_api_gateway_resource.history.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "history_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history.id
  http_method = aws_api_gateway_method.history_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

## [OPTIONS] /history/all - CORS
resource "aws_api_gateway_method" "history-all_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id   = aws_api_gateway_resource.history-all.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "history-all_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-all.id
  http_method = aws_api_gateway_method.history-all_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

## [OPTIONS] /history/{id} - CORS
resource "aws_api_gateway_method" "history-id_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id   = aws_api_gateway_resource.history-id.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "history-id_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-id.id
  http_method = aws_api_gateway_method.history-id_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

## [PUT] /history - Lambda function history
resource "aws_api_gateway_method" "history_put" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id      = aws_api_gateway_resource.history.id
  api_key_required = false
  http_method      = "PUT"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.verify-token.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method_response" "history_put_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history.id
  http_method = "PUT"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.history_put]
}

resource "aws_api_gateway_integration" "lambda_history_put" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id             = aws_api_gateway_resource.history.id
  http_method             = aws_api_gateway_method.history_put.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.history-put.invoke_arn
 
  type                 = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_history_put" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history.id
  http_method = aws_api_gateway_method.history_put.http_method
  status_code = aws_api_gateway_method_response.history_put_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_history_put
  ]
}

resource "aws_lambda_permission" "history_put_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.history-put.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_2.execution_arn}/*/${aws_api_gateway_method.history_put.http_method}/${aws_api_gateway_resource.history.path_part}"
}

## [GET] /history/{id} - Lambda function history
resource "aws_api_gateway_method" "history_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id      = aws_api_gateway_resource.history-id.id
  api_key_required = false
  http_method      = "GET"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.verify-token.id

  request_parameters = {
    "method.request.path.proxy" = true,
    "method.request.path.id" = true    
  }
}

resource "aws_api_gateway_method_response" "history_get_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-id.id
  http_method = "GET"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.history_get]
}

resource "aws_api_gateway_integration" "lambda_history_get" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id             = aws_api_gateway_resource.history-id.id
  http_method             = aws_api_gateway_method.history_get.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.history-get-user.invoke_arn
 
  type                 = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_history_get" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-id.id
  http_method = aws_api_gateway_method.history_get.http_method
  status_code = aws_api_gateway_method_response.history_get_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_history_get
  ]
}

resource "aws_lambda_permission" "history_get_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.history-get-user.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_2.execution_arn}/*/${aws_api_gateway_method.history_get.http_method}/${aws_api_gateway_resource.history.path_part}/{id}"
}

## [DELETE] /history/{id} - Lambda function history
resource "aws_api_gateway_method" "history_delete" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id      = aws_api_gateway_resource.history-id.id
  api_key_required = false
  http_method      = "DELETE"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.verify-token.id

  request_parameters = {
    "method.request.path.proxy" = true,
    "method.request.path.id" = true    
  }
}

resource "aws_api_gateway_method_response" "history_delete_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-id.id
  http_method = "DELETE"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.history_delete]
}

resource "aws_api_gateway_integration" "lambda_history_delete" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id             = aws_api_gateway_resource.history-id.id
  http_method             = aws_api_gateway_method.history_delete.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.history-del-id.invoke_arn
 
  type                 = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_history_delete" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history-id.id
  http_method = aws_api_gateway_method.history_delete.http_method
  status_code = aws_api_gateway_method_response.history_delete_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_history_delete
  ]
}

resource "aws_lambda_permission" "history_delete_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.history-del-id.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_2.execution_arn}/*/${aws_api_gateway_method.history_delete.http_method}/${aws_api_gateway_resource.history.path_part}/{id}"
}

## [GET] /history - Lambda function history
resource "aws_api_gateway_method" "history_get_my" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id      = aws_api_gateway_resource.history.id
  api_key_required = false
  http_method      = "GET"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.verify-token.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method_response" "history_get_my_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history.id
  http_method = "GET"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [aws_api_gateway_method.history_get_my]
}

resource "aws_api_gateway_integration" "lambda_history_get_my" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id             = aws_api_gateway_resource.history.id
  http_method             = aws_api_gateway_method.history_get_my.http_method
  integration_http_method = "POST"

  uri = aws_lambda_function.history-get-my.invoke_arn
 
  type                 = "AWS_PROXY"
}

resource "aws_api_gateway_integration_response" "lambda_history_get_my" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway_2.id
  resource_id = aws_api_gateway_resource.history.id
  http_method = aws_api_gateway_method.history_get_my.http_method
  status_code = aws_api_gateway_method_response.history_get_my_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_history_get_my
  ]
}

resource "aws_lambda_permission" "history_get_my_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.history-get-my.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_2.execution_arn}/*/${aws_api_gateway_method.history_get_my.http_method}/${aws_api_gateway_resource.history.path_part}"
}