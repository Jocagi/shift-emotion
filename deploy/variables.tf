variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "AKIA4OMG2YY4TXDO3VVL"
    secret_key = "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"
  }
}

variable "jwt_secret" {

  type    = string
  default = "abcdefghijklmnopqrstuvwxyz"
}

variable "app_name" {

  type    = string
  default = "shift-emotion-prod"
}

variable "runtime" {

  description = "Runtimes for Lambdas"
  type        = map(any)

  default = {
    nodejs = "nodejs16.x"
    python = "python3.9"
  }
}
