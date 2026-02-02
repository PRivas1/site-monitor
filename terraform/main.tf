provider "aws" {
  region = "us-east-1"
}

resource "aws_apprunner_service" "monitor" {
  service_name = "site-monitor"

  source_configuration {

    authentication_configuration {
      access_role_arn = aws_iam_role.app_role.arn
    }

    image_repository {
      image_identifier      = "370569471710.dkr.ecr.us-east-1.amazonaws.com/site-monitor:latest"
      image_repository_type = "ECR"
      image_configuration { port = "8000" }
    }

  }
}

resource "aws_iam_role" "app_role" {
  name = "pablo-monitor-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "build.apprunner.amazonaws.com" }
    }]
  })

}

resource "aws_iam_role_policy_attachment" "allow_ecr" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

output "app_url" {
  description = "URL of live demo"
  value       = "https://${aws_apprunner_service.monitor.service_url}"
}