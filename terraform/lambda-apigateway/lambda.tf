resource "aws_lambda_function" "lambda" {
  function_name = "lambda-apigateway"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "giancarlopetrini-s3-lambda"
  s3_key    = "lambda.zip"

  handler = "lambda"

  runtime = "go1.x"

  role = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_iam_role" "lambda_role" {
  name = "role-for-gateway"

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
