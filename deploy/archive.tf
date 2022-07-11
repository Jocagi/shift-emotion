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

data "archive_file" "profile_zip" {

  type        = "zip"
  source_dir  = "../functions/profile"
  output_path = "../zipFiles/lambda_profile.zip"
}

data "archive_file" "history-del-id_zip" {

  type        = "zip"
  source_dir  = "../functions/history-del-id"
  output_path = "../zipFiles/lambda_history-del-id.zip"
}

data "archive_file" "history-get-all_zip" {

  type        = "zip"
  source_dir  = "../functions/history-get-all"
  output_path = "../zipFiles/lambda_history-get-all.zip"
}

data "archive_file" "history-get-my_zip" {

  type        = "zip"
  source_dir  = "../functions/history-get-my"
  output_path = "../zipFiles/lambda_history-get-my.zip"
}

data "archive_file" "history-get-user_zip" {

  type        = "zip"
  source_dir  = "../functions/history-get-user"
  output_path = "../zipFiles/lambda_history-get-user.zip"
}

data "archive_file" "history-put_zip" {

  type        = "zip"
  source_dir  = "../functions/history-put"
  output_path = "../zipFiles/lambda_history-put.zip"
}