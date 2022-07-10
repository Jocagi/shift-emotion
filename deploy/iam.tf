//Lambda's roles

// Face details role
resource "aws_iam_role" "face_details_service" {

  name               = "${var.app_name}-face-details-service"
  assume_role_policy = file("./policies/AssumeRoleLambda.json")
}

resource "aws_iam_role_policy_attachment" "ExecutionRole" {

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