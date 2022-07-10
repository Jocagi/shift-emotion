resource "aws_dynamodb_table" "users" {

  name           = "${var.app_name}-users"
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "playlists" {

  name           = "${var.app_name}-playlists"
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "id"
    type = "S"
  }
}
