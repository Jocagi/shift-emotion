// API Gateway configuration
resource "aws_api_gateway_rest_api" "api_gateway" {

  name = "${var.app_name}-api-rest"
  description = "API Gateway de ${var.app_name}"

  binary_media_types = [ 
    "image/jpeg",
    "image/png",
    "application/json"
  ]
}

resource "aws_api_gateway_deployment" "api_deploy" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

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


# /stand/track
resource "aws_api_gateway_resource" "spotify_track" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "track"
}

# /stand/tracks
resource "aws_api_gateway_resource" "spotify_tracks" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "tracks"
}

# /stand/analysis
resource "aws_api_gateway_resource" "spotify_analysis" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "analysis"
}

# /stand/genres
resource "aws_api_gateway_resource" "spotify_genres" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "genres"
}

# /stand/recomendation
resource "aws_api_gateway_resource" "spotify_recomendation" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "recomendation"
}

# /stand/recomendations
resource "aws_api_gateway_resource" "spotify_recomendations" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.spotify.id
  path_part   = "recomendations"
}