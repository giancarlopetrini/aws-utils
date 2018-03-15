resource "aws_api_gateway_rest_api" "lambda-gateway" {
  name        = "lambda-gateway-api"
  description = "Gateway for lambda and terraform"
}

resource "aws_api_gateway_deployment" "lambda-gateway" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.lambda-gateway.id}"
  stage_name  = "test"
}
