// Zip file to upload on S3 as Lambdas source code
data "archive_file" "getEmotion_zip" {

  type        = "zip"
  source_dir  = "../functions/getEmotion"
  output_path = "../zipFiles/lambda_getEmotion.zip"
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