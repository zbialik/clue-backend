
resource "aws_lambda_function" "create-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "start-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip"
  function_name = "start-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "get-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip"
  function_name = "get-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "create-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "start-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip"
  function_name = "start-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "get-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip"
  function_name = "get-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "create-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "get-player" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/players/methods/get/get-player/lambda_function.zip"
  function_name = "get-player"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/players/methods/get/get-player/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "start-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip"
  function_name = "start-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "get-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip"
  function_name = "get-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "create-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip"
  function_name = "create-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/methods/post/create-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "start-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip"
  function_name = "start-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/post/start-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}


resource "aws_lambda_function" "get-game" {
  filename      = "/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip"
  function_name = "get-game"
  role          = "arn:aws:iam::228573559958:role/service-role/ClueLamdaBaseRole"
  handler       = "lambda_function.lambda_handler"
  layers = [
__LAYERS_ARN_LIST__
  ]

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_template.zip"))}"
  source_code_hash = filebase64sha256("/Users/zachbialik/git/clue-backend/src/api_gateway/resources/games/resources/_id_/methods/get/get-game/lambda_function.zip")

  runtime = "python3.8"

  environment {
    variables = {
      table = "CLUE_GAMES"
    }
  }
}

