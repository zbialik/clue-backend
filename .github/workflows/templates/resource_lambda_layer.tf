resource "aws_lambda_layer_version" "__LAYER_NAME__" {
  filename   = "src/lambda/layers/__LAYER_NAME__/layer.zip"
  layer_name = "__LAYER_NAME__"

  compatible_runtimes = ["python3.8"]
}
