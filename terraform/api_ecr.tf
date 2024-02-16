# ---------------------------------------------
# API - ECR
# ---------------------------------------------
resource "aws_ecr_repository" "api_repository" {
  name                 = "${var.project}-${var.environment}-api-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project}-${var.environment}-api-repository"
    Project = var.project
    Env     = var.environment
  }
}
