provider "aws" {
  profile = "tfbuild"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "lambda-apigateway-s3ls" {
  bucket        = "giancarlopetrini-s3-lambda"
  force_destroy = true

  tags {
    Name = "giancarlopetrini-s3-lambda-test"
  }
}
