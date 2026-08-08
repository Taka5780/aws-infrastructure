# ALB Security Group
resource "aws_security_group" "study_alb_sg" {
  name        = "study-alb-sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = aws_vpc.study_vpc.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "study-alb-sg"
  }
}

# EC2 Security Group
resource "aws_security_group" "study_web_sg" {
  name        = "study-web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.study_vpc.id

  ingress {
    description = "SSH connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow study-alb-sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.study_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "study-web-sg"
  }
}


# RDS Security Group
resource "aws_security_group" "study_rds_sg" {
  name        = "study-rds-sg"
  description = "Security Group for Amazon RDS"
  vpc_id      = aws_vpc.study_vpc.id

  ingress {
    description     = "Allow study-web-sg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.study_web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "study-rds-sg"
  }
}
