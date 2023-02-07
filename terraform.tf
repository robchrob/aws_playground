terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket  = "rch-terraform-state-bucket"
    key     = "terraform.tfstate"
    region  = "eu-central-1"
    profile = "default"
  }
}
