# ---------------------------------------------
# API - IAMロール
# ---------------------------------------------
# IAMロールの作成 (App Runner Access Role)
resource "aws_iam_role" "api_app_runner" {
  name = "${var.project}-${var.environment}-api-app-runner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = ["apprunner.amazonaws.com", "build.apprunner.amazonaws.com"]
        },
        Effect = "Allow",
        Sid    = ""
      },
    ]
  })
}

# ---------------------------------------------
# API - IAMロールアタッチメント
# ---------------------------------------------
# AWS管理ポリシーのアタッチメント
resource "aws_iam_role_policy_attachment" "api_app_runner_ecr" {
  role       = aws_iam_role.api_app_runner.name
  policy_arn = var.policy_app_runner_ecs_access_arn
}

# App Runnerサービス作成前の待機時間の設定
resource "time_sleep" "wait_10_seconds" {
  create_duration = "10s"
  triggers = {
    role_arn = aws_iam_role.api_app_runner.arn
  }
}
