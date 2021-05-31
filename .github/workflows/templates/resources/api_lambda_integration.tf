resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.new-clue-backend.id
  resource_id   = aws_api_gateway_resource.__RESOURCE_NAME__.id
  http_method   = "__HTTP_METHOD__"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.new-clue-backend.id
  resource_id             = aws_api_gateway_resource.games.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.new-clue-backend.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.games.path}"
}

