# ---------------------------------------------
# Security Group
# ---------------------------------------------
# API App Runner security group
resource "aws_security_group" "api_app_runner_sg" {
  name        = "${var.project}-${var.environment}-api-app-runner-sg"
  description = "api app runner security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-api-app-runner-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "api_app_runner_out_db" {
  security_group_id        = aws_security_group.api_app_runner_sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = var.db_port
  to_port                  = var.db_port
  source_security_group_id = aws_security_group.db_sg.id
}

# --------------------------------------------------------------------

# DB security group
resource "aws_security_group" "db_sg" {
  name        = "${var.project}-${var.environment}-db-sg"
  description = "db server security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-db-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "db_in_api_app_runner" {
  security_group_id        = aws_security_group.db_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.db_port
  to_port                  = var.db_port
  source_security_group_id = aws_security_group.api_app_runner_sg.id
}
