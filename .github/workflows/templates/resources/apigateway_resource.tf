# API Resources
resource "aws_api_gateway_resource" "__API_GATEWAY_RESOURCE_NAME__" {
  path_part   = "__API_GATEWAY_PATH_PART__"
  parent_id   = __PARENT_RESOURCE_ID_VARIABLE__
  rest_api_id = aws_api_gateway_rest_api.__API_GATEWAY_REST_API_NAME__.id
}

