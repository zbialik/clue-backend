# API Resources
resource "aws_api_gateway_resource" "__API_GATEWAY_RESOURCE_NAME__" {
  path_part   = "__API_GATEWAY_RESOURCE_NAME__"
  parent_id   = aws_api_gateway_rest_api.new-clue-backend.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.new-clue-backend.id
}

