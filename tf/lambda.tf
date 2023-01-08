resource "aws_iam_role" "homepage_lambda_role" {
  name = "homepage_lambda_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_lambda_function" "homepage_lambda" {
  function_name = "homepage_lambda"
  role          = aws_iam_role.homepage_lambda_role.arn
  runtime = "provided"
  handler = "com.chitra.api.lambda.GreetingLambda::handleRequest"
  filename = "function.zip"
  source_code_hash = filebase64sha256("function.zip")
  memory_size = 1024
  environment {
    variables = {
      DISABLE_SIGNAL_HANDLERS = "true"
    }
  }
}
