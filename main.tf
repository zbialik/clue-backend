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

resource "aws_lambda_function" "create_game" {
  filename      = "src/lambda/functions/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    "arn:aws:lambda:us-east-1:228573559958:layer:dynamodb_json:1",
    "arn:aws:lambda:us-east-1:228573559958:layer:clue:1"
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("src/lambda/functions/create-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
