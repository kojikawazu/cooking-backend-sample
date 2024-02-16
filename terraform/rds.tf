# ---------------------------------------------
# RDS parameter group
# ---------------------------------------------
resource "aws_db_parameter_group" "standalone_parametergroup" {
  name   = "${var.project}-${var.environment}-pgql-standalone-parametergroup"
  family = "${var.db_engine}${var.db_version}"

  parameter {
    name  = "client_encoding"
    value = "UTF8"
  }
}

# ---------------------------------------------
# RDS subnet group
# ---------------------------------------------
resource "aws_db_subnet_group" "standalone_subnetgroup" {
  name = "${var.project}-${var.environment}-pgsql-standalone-subnetgroup"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-pgsql-standalone-subnetgroup"
    Project = var.project
    Env     = var.environment
  }
}

# ---------------------------------------------
# RDS instance
# ---------------------------------------------
resource "random_string" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "standalone" {
  engine         = var.db_engine
  engine_version = var.db_full_version

  identifier = "${var.project}-${var.environment}-pgsql-standalone"
  username   = var.db_username
  password   = random_string.db_password.result

  instance_class = var.db_instance_type

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = true

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.standalone_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  port                   = var.db_port

  db_name              = var.db_database
  parameter_group_name = aws_db_parameter_group.standalone_parametergroup.name

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = true

  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name    = "${var.project}-${var.environment}-pgsql-standalone"
    Project = var.project
    Env     = var.environment
  }
}
