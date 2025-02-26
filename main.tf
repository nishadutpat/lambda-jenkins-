provider "aws" {
  region = "us-east-1"


}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my-python-lambda"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = "703671922793.dkr.ecr.us-east-1.amazonaws.com/test:latest"
  memory_size   = 128
  timeout       = 3

  tracing_config {
    mode = "Active"
  }
}





resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

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
