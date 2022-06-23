variable "provider_conf" {

  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "#################"
    secret_key = "###############################33"
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
