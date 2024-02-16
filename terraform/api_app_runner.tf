# ---------------------------------------------
# API - App Runner
# ---------------------------------------------
resource "aws_apprunner_service" "api_app_runner" {
  service_name = "${var.project}-${var.environment}-api-app-runner"
  depends_on   = [time_sleep.wait_10_seconds]

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.api_app_runner.arn
    }

    image_repository {
      image_identifier      = var.app_repository
      image_repository_type = "ECR"
      image_configuration {
        port = "8000" # コンテナがリッスンするポートを指定
        runtime_environment_variables = {
          APP_NAME  = var.app_name
          APP_ENV   = var.app_env
          APP_KEY   = var.app_key
          APP_DEBUG = var.app_debug
          APP_URL   = var.app_url

          LOG_CHANNEL              = var.log_channel
          LOG_DEPRECATIONS_CHANNEL = var.log_deprecations_channel
          LOG_LEVEL                = var.log_level

          DB_CONNECTION = var.db_connection
          DB_HOST       = aws_db_instance.standalone.address
          DB_PORT       = var.db_port
          DB_DATABASE   = var.db_database
          DB_USERNAME   = var.db_username
          DB_PASSWORD   = random_string.db_password.result

          BROADCAST_DRIVER = var.broadcast_driver
          CACHE_DRIVER     = var.cache_driver
          FILESYSTEM_DISK  = var.filesystem_disk
          QUEUE_CONNECTION = var.queue_connection
          SESSION_DRIVER   = var.session_driver
          SESSION_LIFETIME = var.session_lifetime
        }
      }
    }
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.api_app_runner_vpc_connector.arn
    }
  }
}

output "app_runner_service_url" {
  value = aws_apprunner_service.api_app_runner.service_url
}

# ---------------------------------------------
# API - AWS SSM parameter
# ---------------------------------------------
resource "aws_ssm_parameter" "app_url" {
  name  = "/${var.project}/${var.environment}/APP_URL"
  type  = "String"
  value = aws_apprunner_service.api_app_runner.service_url
}
