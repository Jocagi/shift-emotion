resource "aws_dynamodb_table" "users-table" {
  name           = "users-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "pk"
  range_key      = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

   point_in_time_recovery {
    enabled = true
  }
}

resource "aws_dynamodb_table" "playlist-history-table" {
  name           = "playlist-history"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  range_key      = "userId"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

   point_in_time_recovery {
    enabled = true
  }
}