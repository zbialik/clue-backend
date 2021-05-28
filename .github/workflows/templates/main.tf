terraform {
  backend "s3" {
    bucket = "clue-backend"
    key    = "terraform/state"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

data "terraform_remote_state" "clue_backend" {
  backend = "s3"
  config = {
    bucket = "clue-backend"
    key    = "terraform/state"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1" 
}

