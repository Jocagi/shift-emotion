//Lambda's roles

// Face details role
resource "aws_iam_role" "face_details_service" {

  name               = "${var.app_name}-face-details-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "ExecutionRole_face_details_service" {

  role       = aws_iam_role.face_details_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "Rekognition" {

  role       = aws_iam_role.face_details_service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRekognitionReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "S3" {

  role       = aws_iam_role.face_details_service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

// Spotify role
resource "aws_iam_role" "spotify_service" {

  name               = "${var.app_name}-spotify-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "ExecutionRole_spotify_service" {

  role       = aws_iam_role.spotify_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}