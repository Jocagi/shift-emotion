// API Gateway configuration
resource "aws_api_gateway_rest_api" "api_gateway" {

  name = "${var.app_name}-api-rest"
  description = "API Gateway de ${var.app_name}"

  binary_media_types = [ 
    "image/jpeg",
    "image/png"
  ]
}

resource "aws_api_gateway_deployment" "api_deploy" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_description = "Deployed at ${timestamp()}"

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway.body))
  }

  depends_on = [
    aws_api_gateway_integration.lambda_getEmotion,
    aws_api_gateway_integration.face_details_cors,
    aws_api_gateway_integration.lambda_getGenres,
    aws_api_gateway_integration.lambda_getRecomendations,
    aws_api_gateway_integration.lambda_getRecomendation,
    aws_api_gateway_integration.lambda_getTrack,
    aws_api_gateway_integration.lambda_getTracks,
    aws_api_gateway_integration.lambda_getAnalysis,
    aws_api_gateway_integration.spotify_track_cors,
    aws_api_gateway_integration.spotify_tracks_cors,
    aws_api_gateway_integration.spotify_analysis_cors,
    aws_api_gateway_integration.spotify_genres_cors,
    aws_api_gateway_integration.spotify_recomendation_cors,
    aws_api_gateway_integration.spotify_recomendations_cors,
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

resource "aws_api_gateway_stage" "api_gw_stage" {

  deployment_id = aws_api_gateway_deployment.api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = "prod"
}

resource "aws_api_gateway_api_key" "api_key" {

  name = "${var.app_name}-prod-api-key"
}

resource "aws_api_gateway_usage_plan" "api_gw_usage_plan" {

  name = "${var.app_name}-prod-api-gw-usage-plan"

  api_stages {

    api_id = aws_api_gateway_rest_api.api_gateway.id
    stage  = aws_api_gateway_stage.api_gw_stage.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_api_key" {

  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api_gw_usage_plan.id
}

resource "aws_api_gateway_authorizer" "verify-token" {
  name                   = "verify-token"
  rest_api_id            = aws_api_gateway_rest_api.api_gateway.id
  authorizer_uri         = aws_lambda_function.authorize.invoke_arn
  authorizer_credentials = aws_iam_role.authorize_service.arn
}

// API Gateway Resources

# /stand
resource "aws_api_gateway_resource" "face_details" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "face-details"
}

# /spotify
resource "aws_api_gateway_resource" "spotify" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "spotify"
}


# /spotify/track
resource "aws_api_gateway_resource" "spotify_track" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "track"
}

# /spotify/tracks
resource "aws_api_gateway_resource" "spotify_tracks" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "tracks"
}

# /spotify/analysis
resource "aws_api_gateway_resource" "spotify_analysis" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "analysis"
}

# /spotify/genres
resource "aws_api_gateway_resource" "spotify_genres" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "genres"
}

# /spotify/recomendation
resource "aws_api_gateway_resource" "spotify_recomendation" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "recomendation"
}

# /spotify/recomendations
resource "aws_api_gateway_resource" "spotify_recomendations" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "recomendations"
}

# /hello
resource "aws_api_gateway_resource" "hello" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "hello"
}

# /register
resource "aws_api_gateway_resource" "register" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "register"
}

# /login
resource "aws_api_gateway_resource" "login" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "login"
}

# /login
resource "aws_api_gateway_resource" "profile" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "profile"
}