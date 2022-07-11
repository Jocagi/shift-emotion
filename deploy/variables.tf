variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "AKIA4OMG2YY4VZNJCCKJ"
    secret_key = "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"
  }
}

variable "jwt_secret" {

  type    = string
  default = "superseguridad2022"
}

variable "app_name" {

  type    = string
  default = "shift-emotion-v1"
}

variable "runtime" {

  description = "Runtimes for Lambdas"
  type        = map(any)

  default = {
    nodejs = "nodejs16.x"
    python = "python3.9"
  }
}
