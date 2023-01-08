resource "aws_api_gateway_rest_api" "chitralimbu_api" {
  name = "chitralimbu-api"
}

resource "aws_api_gateway_resource" "homepage_resource" {
  parent_id   = aws_api_gateway_rest_api.chitralimbu_api.root_resource_id
  path_part   = "homepage"
  rest_api_id = aws_api_gateway_rest_api.chitralimbu_api.id
}

resource "aws_api_gateway_method" "homepage_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.homepage_resource.id
  rest_api_id   = aws_api_gateway_rest_api.chitralimbu_api.id
}

resource "aws_api_gateway_integration" "chitralimbu_homepage_integration" {
  resource_id             = aws_api_gateway_resource.homepage_resource.id
  rest_api_id             = aws_api_gateway_rest_api.chitralimbu_api.id
  http_method             = aws_api_gateway_method.homepage_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri = aws_lambda_function.homepage_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "chitralimbu_homepage_deployment" {
  rest_api_id = aws_api_gateway_rest_api.chitralimbu_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.chitralimbu_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "chitralimbu_homepage_stage" {
  deployment_id = aws_api_gateway_deployment.chitralimbu_homepage_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.chitralimbu_api.id
  stage_name    = "v1"
}

resource "aws_api_gateway_domain_name" "chitralimbu_api_subdomain" {
  domain_name = "api.${var.domain_name}"
  certificate_arn = aws_acm_certificate_validation.cert_validation.certificate_arn
  endpoint_configuration {
    types = ["EDGE"]
  }

  security_policy = "TLS_1_2"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.homepage_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.chitralimbu_api.execution_arn}/*/*"
}

resource "aws_api_gateway_base_path_mapping" "chitralimbu_subdomain_mapping" {
  api_id      = aws_api_gateway_rest_api.chitralimbu_api.id
  stage_name = aws_api_gateway_stage.chitralimbu_homepage_stage.stage_name
  domain_name = aws_api_gateway_domain_name.chitralimbu_api_subdomain.domain_name
}

resource "aws_route53_record" "chitralimbu_subdomain_record" {
  name    = aws_api_gateway_domain_name.chitralimbu_api_subdomain.domain_name
  type    = "A"
  zone_id = aws_route53_zone.main.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.chitralimbu_api_subdomain.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.chitralimbu_api_subdomain.cloudfront_zone_id
  }
}

resource "aws_api_gateway_method_response" "chitralimbu_backend_200_response" {
  http_method = aws_api_gateway_method.homepage_method.http_method
  resource_id = aws_api_gateway_resource.homepage_resource.id
  rest_api_id = aws_api_gateway_rest_api.chitralimbu_api.id
  status_code = 200
}

resource "aws_api_gateway_integration_response" "chitralimbu_backend_homepage_200_integartion_response" {
  http_method = aws_api_gateway_method.homepage_method.http_method
  resource_id = aws_api_gateway_resource.homepage_resource.id
  rest_api_id = aws_api_gateway_rest_api.chitralimbu_api.id
  status_code = 200
}
