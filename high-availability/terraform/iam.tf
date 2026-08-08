# IAM Role
resource "aws_iam_role" "study_ec2" {
  name        = "study-ec2-ssm-role"
  description = "Allows EC2 instances to call AWS services on your behalf."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }, ]
  })
}

# Attach SSM Managed Policy
resource "aws_iam_role_policy_attachment" "study_ec2_ssm_role" {
  role       = aws_iam_role.study_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# EC2 Instance Profile
resource "aws_iam_instance_profile" "study_ec2_ssm_profile" {
  name = "study-ec2-ssm-role"
  role = aws_iam_role.study_ec2.name
}
