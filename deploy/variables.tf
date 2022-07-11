variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "AKIA4MFYPLVMAL7QU2WU"
    secret_key = "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"
  }
}

variable "jwt_secret" {

  type    = string
  default = "superseguridad2022"
}

variable "app_name" {

  type    = string
  default = "shift-emotion"
}

variable "runtime" {

  description = "Runtimes for Lambdas"
  type        = map(any)

  default = {
    nodejs = "nodejs16.x"
    python = "python3.9"
  }
}
