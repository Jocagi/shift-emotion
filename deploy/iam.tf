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

// Hello role
resource "aws_iam_role" "hello_service" {

  name               = "${var.app_name}-hello-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "hello_ExecutionRole" {

  role       = aws_iam_role.hello_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "hello_policy" {
  name        = "hello-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "hello_DynamoDB" {

  role       = aws_iam_role.hello_service.name
  policy_arn = aws_iam_policy.hello_policy.arn
}

// register role
resource "aws_iam_role" "register_service" {

  name               = "${var.app_name}-register-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "register_ExecutionRole" {

  role       = aws_iam_role.register_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "register_policy" {
  name        = "register-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "register_DynamoDB" {

  role       = aws_iam_role.register_service.name
  policy_arn = aws_iam_policy.register_policy.arn
}

// login role
resource "aws_iam_role" "login_service" {

  name               = "${var.app_name}-login-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "login_ExecutionRole" {

  role       = aws_iam_role.login_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "login_policy" {
  name        = "login-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "login_DynamoDB" {

  role       = aws_iam_role.login_service.name
  policy_arn = aws_iam_policy.login_policy.arn
}

// authorize role
resource "aws_iam_role" "authorize_service" {

  name               = "${var.app_name}-authorize-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "authorize_ExecutionRole" {

  role       = aws_iam_role.authorize_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "authorize_policy" {
  name        = "authorize-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "authorize_DynamoDB" {

  role       = aws_iam_role.authorize_service.name
  policy_arn = aws_iam_policy.authorize_policy.arn
}

resource "aws_iam_role_policy_attachment" "authorize_InvokeFunction" {

  role       = aws_iam_role.authorize_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

// profile role
resource "aws_iam_role" "profile_service" {

  name               = "${var.app_name}-profile-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "profile_ExecutionRole" {

  role       = aws_iam_role.profile_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "profile_policy" {
  name        = "profile-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "profile_DynamoDB" {

  role       = aws_iam_role.profile_service.name
  policy_arn = aws_iam_policy.profile_policy.arn
}

// history-put role
resource "aws_iam_role" "history-put_service" {

  name               = "${var.app_name}-history-put-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "history-put_ExecutionRole" {

  role       = aws_iam_role.history-put_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "history-put_policy" {
  name        = "history-put-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "history-put_DynamoDB" {

  role       = aws_iam_role.history-put_service.name
  policy_arn = aws_iam_policy.history-put_policy.arn
}

// history-get-user role
resource "aws_iam_role" "history-get-user_service" {

  name               = "${var.app_name}-history-get-user-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "history-get-user_ExecutionRole" {

  role       = aws_iam_role.history-get-user_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "history-get-user_policy" {
  name        = "history-get-user-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "history-get-user_DynamoDB" {

  role       = aws_iam_role.history-get-user_service.name
  policy_arn = aws_iam_policy.history-get-user_policy.arn
}

// history-get-my role
resource "aws_iam_role" "history-get-my_service" {

  name               = "${var.app_name}-history-get-my-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "history-get-my_ExecutionRole" {

  role       = aws_iam_role.history-get-my_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "history-get-my_policy" {
  name        = "history-get-my-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "history-get-my_DynamoDB" {

  role       = aws_iam_role.history-get-my_service.name
  policy_arn = aws_iam_policy.history-get-my_policy.arn
}

// history-get-all role
resource "aws_iam_role" "history-get-all_service" {

  name               = "${var.app_name}-history-get-all-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "history-get-all_ExecutionRole" {

  role       = aws_iam_role.history-get-all_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "history-get-all_policy" {
  name        = "history-get-all-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "history-get-all_DynamoDB" {

  role       = aws_iam_role.history-get-all_service.name
  policy_arn = aws_iam_policy.history-get-all_policy.arn
}

// history-del-id role
resource "aws_iam_role" "history-del-id_service" {

  name               = "${var.app_name}-history-del-id-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "history-del-id_ExecutionRole" {

  role       = aws_iam_role.history-del-id_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "history-del-id_policy" {
  name        = "history-del-id-policy"
  description = "A test policy"

  policy = file("./policies/LambdaDynamoDB.json")
}

resource "aws_iam_role_policy_attachment" "history-del-id_DynamoDB" {

  role       = aws_iam_role.history-del-id_service.name
  policy_arn = aws_iam_policy.history-del-id_policy.arn
}