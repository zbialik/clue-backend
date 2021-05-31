resource "aws_lambda_layer_version" "__LAYER_NAME__" {
  filename   = "__LAYER_ZIP_PATH__"
  layer_name = "__LAYER_NAME__"
  compatible_runtimes = ["python3.8"]
}

