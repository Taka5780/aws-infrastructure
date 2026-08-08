# rds subnet group
resource "aws_db_subnet_group" "study_db_subnet_group" {
  name        = "study-db-subnet-group"
  description = "Study DB Subnet Group"
  subnet_ids = [
    aws_subnet.private_study_subnet.id,
    aws_subnet.private_study_subnet_2.id
  ]

  tags = {
    Name = "study-db-subnet-group"
  }
}

# DB Instance
resource "aws_db_instance" "study_db" {
  engine                   = "mysql"
  engine_version           = "8.4.9"
  identifier               = "study-db"
  username                 = var.db_username
  password                 = var.db_password
  instance_class           = "db.t4g.micro"
  storage_type             = "gp3"
  allocated_storage        = 20
  db_subnet_group_name     = aws_db_subnet_group.study_db_subnet_group.name
  vpc_security_group_ids   = [aws_security_group.study_rds_sg.id]
  database_insights_mode   = "standard"
  delete_automated_backups = false
  backup_retention_period  = 1
  db_name                  = "studydb"
  storage_encrypted        = true
  deletion_protection      = false
  publicly_accessible      = false
  skip_final_snapshot      = true
}
