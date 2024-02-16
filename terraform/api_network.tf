resource "aws_apprunner_vpc_connector" "api_app_runner_vpc_connector" {
  vpc_connector_name = "${var.project}-${var.environment}-api-app-runner-vpc-connector"
  subnets = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id,
  ]
  security_groups = [aws_security_group.api_app_runner_sg.id]
}
