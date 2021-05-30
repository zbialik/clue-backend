resource "aws_lambda_function" "__FUNCTION_NAME__" {
  filename      = "__FUNCTION_ZIP_PATH__"
  function_name = "__FUNCTION_NAME__"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
    aws_lambda_layer_version.clue.arn,
    aws_lambda_layer_version.dynamodb_json.arn
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("__FUNCTION_ZIP_PATH__")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}

