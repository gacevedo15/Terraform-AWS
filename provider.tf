provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "actrafer-terraform-state"
    key    = "states/"
    region = "eu-west-1"
  }
}

