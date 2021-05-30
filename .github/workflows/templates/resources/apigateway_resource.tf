# API Resources
resource "aws_api_gateway_resource" "games" {
  path_part   = "games"
  parent_id   = aws_api_gateway_rest_api.new-clue-backend.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.new-clue-backend.id
}

