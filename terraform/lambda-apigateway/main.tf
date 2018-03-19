provider "aws" {
  profile = "tfbuild"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "lambda-apigateway-s3" {
  bucket        = "giancarlopetrini-s3-lambda"
  force_destroy = true

  tags {
    Name = "giancarlopetrini-s3-lambda-test"
  }
}

data "aws_route53_zone" "selected" {
  name = "giancarlopetrini.com."
}

resource "aws_route53_record" "apitest" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "apitest.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = "3600"
  records = ["${aws_api_gateway_deployment.lambda-gateway.invoke_url}"]
}
