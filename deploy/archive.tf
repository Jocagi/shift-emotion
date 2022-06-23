// Zip file to upload on S3 as Lambdas source code
data "archive_file" "getEmotion_zip" {

  type        = "zip"
  source_dir  = "../functions/getEmotion"
  output_path = "../zipFiles/lambda_getEmotion.zip"
}