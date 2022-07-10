## [POST] /face-details - Lambda function getEmotion
resource "aws_api_gateway_method" "face_details_post" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.face_details.id
  api_key_required = true
  http_method      = "POST"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "face_details_post_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_post.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getEmotion" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.face_details.id
  http_method             = aws_api_gateway_method.face_details_post.http_method
  integration_http_method = aws_api_gateway_method.face_details_post.http_method

  uri = aws_lambda_function.getEmotion.invoke_arn

  type                 = "AWS"
  content_handling     = "CONVERT_TO_TEXT"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "image/jpeg" = "{\"content\": \"$input.body\"}",
    "image/png"  = "{\"content\": \"$input.body\"}"
  }
}

resource "aws_api_gateway_integration_response" "lambda_getEmotion" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_post.http_method
  status_code = aws_api_gateway_method_response.face_details_post_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getEmotion
  ]
}

resource "aws_lambda_permission" "getEmotion_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getEmotion.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.face_details_post.http_method}/${aws_api_gateway_resource.face_details.path_part}"
}

## [OPTIONS] /face-details - CORS
resource "aws_api_gateway_method" "face_details_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.face_details.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "face_details_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "face_details_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "face_details_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.face_details.id
  http_method = aws_api_gateway_method.face_details_cors.http_method
  status_code = aws_api_gateway_method_response.face_details_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.face_details_cors
  ]
}

## [GET] /spotify/track 
resource "aws_api_gateway_method" "spotify_track_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_track.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_track_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_track.id
  http_method = aws_api_gateway_method.spotify_track_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getTrack" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_track.id
  http_method             = aws_api_gateway_method.spotify_track_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_track_get.http_method

  uri = aws_lambda_function.getTrack.invoke_arn

  type                 = "AWS"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = "{ \"trackName\": \"$input.params('trackName')\" }"
  }
}

resource "aws_api_gateway_integration_response" "lambda_getTrack" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_track.id
  http_method = aws_api_gateway_method.spotify_track_get.http_method
  status_code = aws_api_gateway_method_response.spotify_track_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getTrack
  ]
}

resource "aws_lambda_permission" "getTrack_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getTrack.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_track.path_part}"
}

## [OPTIONS] /spotify/track - CORS
resource "aws_api_gateway_method" "spotify_track_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_track.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_track_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_track.id
  http_method = aws_api_gateway_method.spotify_track_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_track_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_track.id
  http_method = aws_api_gateway_method.spotify_track_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_track_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_track.id
  http_method = aws_api_gateway_method.spotify_track_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_track_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.face_details_cors
  ]
}

## [GET] /spotify/tracks
resource "aws_api_gateway_method" "spotify_tracks_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_tracks.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_tracks_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_tracks.id
  http_method = aws_api_gateway_method.spotify_tracks_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getTracks" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_tracks.id
  http_method             = aws_api_gateway_method.spotify_tracks_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_tracks_get.http_method

  uri = aws_lambda_function.getTracks.invoke_arn

  type                 = "AWS"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = "{ \"trackName\": \"$input.params('trackName')\" }"
  }
}

resource "aws_api_gateway_integration_response" "lambda_getTracks" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_tracks.id
  http_method = aws_api_gateway_method.spotify_tracks_get.http_method
  status_code = aws_api_gateway_method_response.spotify_tracks_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getTracks
  ]
}

resource "aws_lambda_permission" "getTracks_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getTracks.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_tracks.path_part}"
}

## [OPTIONS] /spotify/tracks - CORS
resource "aws_api_gateway_method" "spotify_tracks_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_tracks.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_tracks_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_tracks.id
  http_method = aws_api_gateway_method.spotify_tracks_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_tracks_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_tracks.id
  http_method = aws_api_gateway_method.spotify_tracks_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_tracks_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_tracks.id
  http_method = aws_api_gateway_method.spotify_tracks_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_tracks_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.spotify_tracks_cors
  ]
}

## [GET] /spotify/analysis
resource "aws_api_gateway_method" "spotify_analysis_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_analysis.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_analysis_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_analysis.id
  http_method = aws_api_gateway_method.spotify_analysis_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getAnalysis" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_analysis.id
  http_method             = aws_api_gateway_method.spotify_analysis_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_analysis_get.http_method

  uri = aws_lambda_function.getValence.invoke_arn

  type                 = "AWS"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = "{ \"trackId\": \"$input.params('trackId')\" }"
  }
}

resource "aws_api_gateway_integration_response" "lambda_getAnalysis" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_analysis.id
  http_method = aws_api_gateway_method.spotify_analysis_get.http_method
  status_code = aws_api_gateway_method_response.spotify_analysis_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getAnalysis
  ]
}

resource "aws_lambda_permission" "getAnalysis_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getValence.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_analysis.path_part}"
}

## [OPTIONS] /spotify/analysis - CORS
resource "aws_api_gateway_method" "spotify_analysis_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_analysis.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_analysis_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_analysis.id
  http_method = aws_api_gateway_method.spotify_analysis_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_analysis_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_analysis.id
  http_method = aws_api_gateway_method.spotify_analysis_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_analysis_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_analysis.id
  http_method = aws_api_gateway_method.spotify_analysis_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_analysis_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.spotify_analysis_cors
  ]
}

## [GET] /spotify/genres
resource "aws_api_gateway_method" "spotify_genres_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_genres.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_genres_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_genres.id
  http_method = aws_api_gateway_method.spotify_genres_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getGenres" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_genres.id
  http_method             = aws_api_gateway_method.spotify_genres_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_genres_get.http_method

  type = "AWS"

  uri = aws_lambda_function.getGenres.invoke_arn
}

resource "aws_api_gateway_integration_response" "lambda_getGenres" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_genres.id
  http_method = aws_api_gateway_method.spotify_genres_get.http_method
  status_code = aws_api_gateway_method_response.spotify_genres_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getGenres
  ]
}

resource "aws_lambda_permission" "getGenres_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getGenres.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_genres.path_part}"
}

## [OPTIONS] /spotify/genres - CORS
resource "aws_api_gateway_method" "spotify_genres_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_genres.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_genres_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_genres.id
  http_method = aws_api_gateway_method.spotify_genres_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_genres_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_genres.id
  http_method = aws_api_gateway_method.spotify_genres_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_genres_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_genres.id
  http_method = aws_api_gateway_method.spotify_genres_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_genres_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.spotify_genres_cors
  ]
}

## [GET] /spotify/recomendation
resource "aws_api_gateway_method" "spotify_recomendation_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_recomendation.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_recomendation_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendation.id
  http_method = aws_api_gateway_method.spotify_recomendation_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getRecomendation" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_recomendation.id
  http_method             = aws_api_gateway_method.spotify_recomendation_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_recomendation_get.http_method

  type = "AWS"
  
  uri = aws_lambda_function.getRecommendation.invoke_arn
}

resource "aws_api_gateway_integration_response" "lambda_getRecomendation" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendation.id
  http_method = aws_api_gateway_method.spotify_recomendation_get.http_method
  status_code = aws_api_gateway_method_response.spotify_recomendation_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getRecomendation
  ]
}

resource "aws_lambda_permission" "getRecomendation_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getRecommendation.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_recomendation.path_part}"
}

## [OPTIONS] /spotify/recomendation - CORS
resource "aws_api_gateway_method" "spotify_recomendation_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_recomendation.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_recomendation_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendation.id
  http_method = aws_api_gateway_method.spotify_recomendation_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_recomendation_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendation.id
  http_method = aws_api_gateway_method.spotify_recomendation_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_recomendation_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendation.id
  http_method = aws_api_gateway_method.spotify_recomendation_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_recomendation_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.spotify_recomendation_cors
  ]
}

## [GET] /spotify/recomendations
resource "aws_api_gateway_method" "spotify_recomendations_get" {

  rest_api_id      = aws_api_gateway_rest_api.api_gateway.id
  resource_id      = aws_api_gateway_resource.spotify_recomendations.id
  api_key_required = true
  http_method      = "GET"
  authorization    = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_recomendations_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendations.id
  http_method = aws_api_gateway_method.spotify_recomendations_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration" "lambda_getRecomendations" {

  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.spotify_recomendations.id
  http_method             = aws_api_gateway_method.spotify_recomendations_get.http_method
  integration_http_method = aws_api_gateway_method.spotify_recomendations_get.http_method

  type = "AWS"
  
  uri = aws_lambda_function.getRecommendations.invoke_arn
}

resource "aws_api_gateway_integration_response" "lambda_getRecomendations" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendations.id
  http_method = aws_api_gateway_method.spotify_recomendations_get.http_method
  status_code = aws_api_gateway_method_response.spotify_recomendations_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getRecomendations
  ]
}

resource "aws_lambda_permission" "getRecomendations_api_gw" {

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getRecommendations.function_name
  principal     = "apigateway.amazonaws.com"

  // {api_arn}/*/{http_method}/{resource_path}
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/${aws_api_gateway_method.spotify_track_get.http_method}/${aws_api_gateway_resource.spotify.path_part}/${aws_api_gateway_resource.spotify_recomendations.path_part}"
}

## [OPTIONS] /spotify/recomendation - CORS
resource "aws_api_gateway_method" "spotify_recomendations_cors" {

  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.spotify_recomendations.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "spotify_recomendations_cors_response_200" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendations.id
  http_method = aws_api_gateway_method.spotify_recomendations_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "spotify_recomendations_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendations.id
  http_method = aws_api_gateway_method.spotify_recomendations_cors.http_method

  type = "MOCK"

  request_templates = {
    "application/json" = "{'statusCode': 200}"
  }
}

resource "aws_api_gateway_integration_response" "spotify_recomendations_cors" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.spotify_recomendations.id
  http_method = aws_api_gateway_method.spotify_recomendations_cors.http_method
  status_code = aws_api_gateway_method_response.spotify_recomendations_cors_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,PATCH,DELETE,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.spotify_recomendations_cors
  ]
}