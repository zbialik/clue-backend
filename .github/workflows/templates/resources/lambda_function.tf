resource "aws_lambda_function" "__FUNCTION_NAME__" {
  filename      = "__FUNCTION_ZIP_PATH__"
  function_name = "__FUNCTION_NAME__"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]
  
  source_code_hash = filebase64sha256("__FUNCTION_ZIP_PATH__")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}

