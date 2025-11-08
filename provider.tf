terraform {
  backend "s3" {
    bucket  = "terraform-state-paulo-20251108"
    key     = "ec2/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}