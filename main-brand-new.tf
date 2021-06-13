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
resource "aws_lambda_function" "create-game" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
resource "aws_lambda_function" "get-all-games" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/methods/get/get-all-games/lambda_function.zip"
  function_name = "get-all-games"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/methods/get/get-all-games/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
resource "aws_lambda_function" "get-game" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/methods/get/get-game/lambda_function.zip"
  function_name = "get-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/methods/get/get-game/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
resource "aws_lambda_function" "start-game" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/resources/start-game/methods/post/start-game/lambda_function.zip"
  function_name = "start-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/resources/start-game/methods/post/start-game/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
resource "aws_lambda_function" "move-character" {
  filename      = "/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/resources/move/methods/post/move-character/lambda_function.zip"
  function_name = "move-character"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  source_code_hash = filebase64sha256("/home/runner/work/clue-backend/clue-backend/src/api_gateway/resources/games/resources/{game_id}/resources/move/methods/post/move-character/lambda_function.zip")
  runtime = "python3.8"
  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}
# API Gateway
resource "aws_api_gateway_rest_api" "clue-backend" {
  name = "clue-backend"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
# API Resources
resource "aws_api_gateway_resource" "games" {
  path_part   = "games"
  parent_id   = aws_api_gateway_rest_api.clue-backend.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.clue-backend.id
}
# API Resources
resource "aws_api_gateway_resource" "game_id" {
  path_part   = "{game_id}"
  parent_id   = aws_api_gateway_resource.games.id
  rest_api_id = aws_api_gateway_rest_api.clue-backend.id
}
# API Resources
resource "aws_api_gateway_resource" "start-game" {
  path_part   = "start-game"
  parent_id   = aws_api_gateway_resource.game_id.id
  rest_api_id = aws_api_gateway_rest_api.clue-backend.id
}
# API Resources
resource "aws_api_gateway_resource" "move" {
  path_part   = "move"
  parent_id   = aws_api_gateway_resource.game_id.id
  rest_api_id = aws_api_gateway_rest_api.clue-backend.id
}
resource "aws_api_gateway_method" "games_POST" {
  rest_api_id   = aws_api_gateway_rest_api.clue-backend.id
  resource_id   = aws_api_gateway_resource.games.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "games_POST" {
  rest_api_id             = aws_api_gateway_rest_api.clue-backend.id
  resource_id             = aws_api_gateway_resource.games.id
  http_method             = aws_api_gateway_method.games_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.create-game.invoke_arn
}
resource "aws_lambda_permission" "apigw_lambdagames_POST" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create-game.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue-backend.id}/*/${aws_api_gateway_method.games_POST.http_method}${aws_api_gateway_resource.games.path}"
}
resource "aws_api_gateway_method" "games_GET" {
  rest_api_id   = aws_api_gateway_rest_api.clue-backend.id
  resource_id   = aws_api_gateway_resource.games.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "games_GET" {
  rest_api_id             = aws_api_gateway_rest_api.clue-backend.id
  resource_id             = aws_api_gateway_resource.games.id
  http_method             = aws_api_gateway_method.games_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get-all-games.invoke_arn
}
resource "aws_lambda_permission" "apigw_lambdagames_GET" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-all-games.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue-backend.id}/*/${aws_api_gateway_method.games_GET.http_method}${aws_api_gateway_resource.games.path}"
}
resource "aws_api_gateway_method" "game_id_GET" {
  rest_api_id   = aws_api_gateway_rest_api.clue-backend.id
  resource_id   = aws_api_gateway_resource.game_id.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "game_id_GET" {
  rest_api_id             = aws_api_gateway_rest_api.clue-backend.id
  resource_id             = aws_api_gateway_resource.game_id.id
  http_method             = aws_api_gateway_method.game_id_GET.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get-game.invoke_arn
}
resource "aws_lambda_permission" "apigw_lambdagame_id_GET" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-game.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue-backend.id}/*/${aws_api_gateway_method.game_id_GET.http_method}${aws_api_gateway_resource.game_id.path}"
}
resource "aws_api_gateway_method" "start-game_POST" {
  rest_api_id   = aws_api_gateway_rest_api.clue-backend.id
  resource_id   = aws_api_gateway_resource.start-game.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "start-game_POST" {
  rest_api_id             = aws_api_gateway_rest_api.clue-backend.id
  resource_id             = aws_api_gateway_resource.start-game.id
  http_method             = aws_api_gateway_method.start-game_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.start-game.invoke_arn
}
resource "aws_lambda_permission" "apigw_lambdastart-game_POST" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start-game.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue-backend.id}/*/${aws_api_gateway_method.start-game_POST.http_method}${aws_api_gateway_resource.start-game.path}"
}
resource "aws_api_gateway_method" "move_POST" {
  rest_api_id   = aws_api_gateway_rest_api.clue-backend.id
  resource_id   = aws_api_gateway_resource.move.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "move_POST" {
  rest_api_id             = aws_api_gateway_rest_api.clue-backend.id
  resource_id             = aws_api_gateway_resource.move.id
  http_method             = aws_api_gateway_method.move_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.move-character.invoke_arn
}
resource "aws_lambda_permission" "apigw_lambdamove_POST" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.move-character.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.clue-backend.id}/*/${aws_api_gateway_method.move_POST.http_method}${aws_api_gateway_resource.move.path}"
}