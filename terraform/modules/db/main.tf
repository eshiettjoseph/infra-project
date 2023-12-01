resource "aws_db_subnet_group" "test_db_subnet_group" {
  name       = "test-db-subnet-group"
  subnet_ids = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]

}

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_default_vpc.default_vpc.id

  ingress {
    description = "connection form the VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_secretsmanager_secret" "db_auth" {
  name                    = "db-auth"
  recovery_window_in_days = 0
  #checkov:skip=CKV2_AWS_57: Disabled Secrets Manager secrets automatic rotation
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db_auth.id
  secret_string = random_password.db_password.result
}

resource "aws_db_instance" "rds_pgs" {
  identifier                          = "rds-pgs"
  allocated_storage                   = 10
  engine                              = "postgres"
  db_name                             = "postgres"
  engine_version                      = "15.3"
  instance_class                      = "db.t3.micro"
  username                            = "go-rest-api"
  password                            = aws_secretsmanager_secret_version.db.secret_string
  multi_az                            = true
  db_subnet_group_name                = aws_db_subnet_group.test_db_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.rds_sg.id]
  backup_retention_period             = 35
  backup_window                       = "21:00-23:00"
  iam_database_authentication_enabled = true
  final_snapshot_identifier           = false
}
