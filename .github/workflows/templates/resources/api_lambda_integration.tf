resource "aws_api_gateway_method" "__API_GATEWAY_RESOURCE_NAME_____API_GATEWAY_HTTP_METHOD__" {
  rest_api_id   = aws_api_gateway_rest_api.__API_GATEWAY_REST_API_NAME__.id
  resource_id   = aws_api_gateway_resource.__API_GATEWAY_RESOURCE_NAME__.id
  http_method   = "__API_GATEWAY_HTTP_METHOD__"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "__API_GATEWAY_RESOURCE_NAME_____API_GATEWAY_HTTP_METHOD__" {
  rest_api_id             = aws_api_gateway_rest_api.__API_GATEWAY_REST_API_NAME__.id
  resource_id             = aws_api_gateway_resource.__API_GATEWAY_RESOURCE_NAME__.id
  http_method             = aws_api_gateway_method.__API_GATEWAY_RESOURCE_NAME_____API_GATEWAY_HTTP_METHOD__.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.__FUNCTION_NAME__.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda__API_GATEWAY_RESOURCE_NAME_____API_GATEWAY_HTTP_METHOD__" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.__FUNCTION_NAME__.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:228573559958:${aws_api_gateway_rest_api.__API_GATEWAY_REST_API_NAME__.id}/*/${aws_api_gateway_method.__API_GATEWAY_RESOURCE_NAME_____API_GATEWAY_HTTP_METHOD__.http_method}${aws_api_gateway_resource.__API_GATEWAY_RESOURCE_NAME__.path}"
}

