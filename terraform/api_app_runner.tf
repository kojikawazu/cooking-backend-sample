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
      image_identifier      = "605030569844.dkr.ecr.ap-northeast-1.amazonaws.com/cooking-dev-api-repository:latest"
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
          DB_HOST       = var.db_host
          DB_PORT       = var.db_port
          DB_DATABASE   = var.db_database
          DB_USERNAME   = var.db_username
          DB_PASSWORD   = var.db_password

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
      egress_type = "DEFAULT"
    }
  }
}
