terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  backend "s3" {
    bucket = "myajay-terraform-state"
    region = "ca-central-1"
    key    = "myajay-terraform.tfstate"
  }
}

provider "aws" {
  region = "ca-central-1"
}