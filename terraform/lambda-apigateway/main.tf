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
  name = "giancarlopetrini.com"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "apitest.giancarlopetrini.com"
  validation_method = "DNS"
}

output "validation-options" {
  value = "${aws_acm_certificate.cert.domain_validation_options}"
}

resource "aws_route53_record" "cert-valid" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = "3600"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
}

output "certificate-info" {
  value = [
    "${aws_acm_certificate.cert.arn}",
  ]
}

/* resource "aws_api_gateway_domain_name" "apitest" {
  domain_name = "apitest"

  #certificate_name        = "example-api"
  #certificate_body        = "${file("${path.module}/example.com/example.crt")}"
  #certificate_chain       = "${file("${path.module}/example.com/ca.crt")}"
  #certificate_private_key = "${file("${path.module}/example.com/example.key")}"
}

resource "aws_route53_record" "apitest" {
  zone_id = "${data.aws_route53_zone.selected.id}" # See aws_route53_zone for how to create this

  name = "${aws_api_gateway_domain_name.apitest.domain_name}"
  type = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.apitest.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.apitest.cloudfront_zone_id}"
    evaluate_target_health = true
  }
} */

