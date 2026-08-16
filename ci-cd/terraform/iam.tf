# IAM Role
resource "aws_iam_role" "study_ec2_s3_role" {
  name        = "study_ec2_s3_role"
  description = "Role for EC2 to Access S3."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Roleの許可設定
resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.study_ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Creating an Instance Profile
resource "aws_iam_instance_profile" "study_ec2_profile" {
  name = "study_ci_cd_ec2_profile"
  role = aws_iam_role.study_ec2_s3_role.name
}
