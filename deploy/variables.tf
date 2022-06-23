variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "AKIA4MFYPLVMDDNWF2GS"
    secret_key = "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"
  }
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
