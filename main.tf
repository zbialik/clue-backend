terraform {
  backend "s3" {
    bucket = "clue-backend"
    key    = "terraform/v1/state"
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
# data "terraform_remote_state" "clue_backend" {
#   backend = "s3"
#   config = {
#     bucket = "clue-backend"
#     key    = "terraform/v1/state"
#     region = "us-east-1"
#   }
# }
provider "aws" {
  profile = "default"
  region  = "us-east-1" 
}

# Lambda Layers
resource "aws_lambda_layer_version" "dynamodb_json" {
  filename   = "/home/runner/work/clue-backend/clue-backend/src/lambda/layers/dynamodb_json/layer.zip"
  layer_name = "dynamodb_json"
  compatible_runtimes = ["python3.8"]
}
resource "aws_lambda_layer_version" "clue" {
  filename   = "/home/runner/work/clue-backend/clue-backend/src/lambda/layers/clue/layer.zip"
  layer_name = "clue"
  compatible_runtimes = ["python3.8"]
}

# Lambda Functions
resource "aws_lambda_function" "game-controller" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/lambda/functions/game-controller/lambda_function.zip"
  function_name = "game-controller"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/lambda/functions/game-controller/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}

# API Gateway
resource "aws_api_gateway_rest_api" "clue" {
  name = "clue"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# API Gateway Resources
resource "aws_api_gateway_resource" "api_resource_games" {
  path_part   = "games"
  parent_id   = aws_api_gateway_rest_api.clue.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.clue.id
}
resource "aws_api_gateway_resource" "api_resource_game_id" {
  path_part   = "{game_id}"
  parent_id   = aws_api_gateway_resource.api_resource_games.id
  rest_api_id = aws_api_gateway_rest_api.clue.id
}

# API Gateway Methods
resource "aws_api_gateway_method" "api_method_games" {
  rest_api_id   = aws_api_gateway_rest_api.clue.id
  resource_id   = aws_api_gateway_resource.api_resource_games.id
  http_method   = "ANY"
  authorization = "NONE"
}

# API Gateway - Lambda Integrations and Permission
resource "aws_api_gateway_integration" "lambda_api_integration_games" {
  rest_api_id             = aws_api_gateway_rest_api.clue.id
  resource_id             = aws_api_gateway_resource.api_resource_games.id
  http_method             = aws_api_gateway_method.api_method_games.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.game-controller.invoke_arn
}
resource "aws_lambda_permission" "lamda_api_permissions_games" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.game-controller.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue.id}/*/${aws_api_gateway_method.api_method_games.http_method}${aws_api_gateway_resource.api_resource_games.path}"
}