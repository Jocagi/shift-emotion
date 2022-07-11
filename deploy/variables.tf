variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-2"
    access_key = "AKIASI3Y4HHVLAKWG35S"
    secret_key = "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"
  }
}

variable "jwt_secret" {

  type    = string
  default = "abcdefghijklmnopqrstuvwxyz"
}

variable "app_name" {

  type    = string
  default = "shift-emotion-jose"
}

variable "runtime" {

  description = "Runtimes for Lambdas"
  type        = map(any)

  default = {
    nodejs = "nodejs16.x"
    python = "python3.9"
  }
}
