// Zip file to upload on S3 as Lambdas source code
data "archive_file" "getEmotion_zip" {

  type        = "zip"
  source_dir  = "../functions/getEmotion"
  output_path = "../zipFiles/lambda_getEmotion.zip"
}

data "archive_file" "getGenres_zip" {

  type        = "zip"
  source_dir  = "../functions/getGenres"
  output_path = "../zipFiles/lambda_getGenres.zip"
}

data "archive_file" "getRecomendation_zip" {

  type        = "zip"
  source_dir  = "../functions/getRecomendation"
  output_path = "../zipFiles/lambda_getRecomendation.zip"
}
  
data "archive_file" "getRecomendations_zip" {

  type        = "zip"
  source_dir  = "../functions/getRecomendations"
  output_path = "../zipFiles/lambda_getRecomendations.zip"
}
  
data "archive_file" "getTrack_zip" {

  type        = "zip"
  source_dir  = "../functions/getTrack"
  output_path = "../zipFiles/lambda_getTrack.zip"
}
  
data "archive_file" "getTracks_zip" {

  type        = "zip"
  source_dir  = "../functions/getTracks"
  output_path = "../zipFiles/lambda_getTracks.zip"
}

data "archive_file" "getValence_zip" {

  type        = "zip"
  source_dir  = "../functions/getValence"
  output_path = "../zipFiles/lambda_getValence.zip"
}

data "archive_file" "hello_zip" {

  type        = "zip"
  source_dir  = "../functions/test"
  output_path = "../zipFiles/lambda_hello.zip"
}

data "archive_file" "register_zip" {

  type        = "zip"
  source_dir  = "../functions/register"
  output_path = "../zipFiles/lambda_register.zip"
}

data "archive_file" "login_zip" {

  type        = "zip"
  source_dir  = "../functions/login"
  output_path = "../zipFiles/lambda_login.zip"
}

data "archive_file" "authorize_zip" {

  type        = "zip"
  source_dir  = "../functions/authorize"
  output_path = "../zipFiles/lambda_authorize.zip"
}