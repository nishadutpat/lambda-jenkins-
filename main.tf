provider "aws" {
  region = "us-east-1"


}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my-python-lambda"
  image_uri     = "${aws_ecr_repository.my_repo.repository_url}:latest"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
}

resource "aws_ecr_repository" "my_repo" {
  name = "my-python-app"

  lifecycle {
    ignore_changes = [image_tag_mutability]
  }
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

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
