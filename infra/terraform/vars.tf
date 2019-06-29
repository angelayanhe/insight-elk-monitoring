/*

var.tf 

This file initializes Terraform variables.

Please specify the following environment variables:
TF_VAR_AWS_ACCESS_KEY = <your-access-key>
TF_VAR_AWS_SECRET_KEY = <your-secret-key>

*/

variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

# Overwritten by build.sh
variable "AWS_REGION" { default = "us-west-2" }

# Overwritten by build.sh
variable "AMIS" {
  type = "map"
  default = {
    spark = "ami-0c0a0efca99a1d499"
    postgres = "ami-00d2d718ced742e70"
    flask = ""
    ubuntu = "ami-ba602bc2"
  }
}

# Overwritten by build.sh
variable "NUM_WORKERS" { default = 2 }

# Overwritten by build.sh
variable "PATH_TO_PUBLIC_KEY" { default = "~/.ssh/id_rsa.pub" }

# Overwritten by build.sh
variable "PATH_TO_PRIVATE_KEY" { default = "~/.ssh/id_rsa" }
