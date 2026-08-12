# IAM Role
resource "aws_iam_role" "study_lambda_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole"
        ],
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
      }
    ] }
  )
  name        = "study_event_driven_lambda_role"
  description = "Allows Lambda to access S3, publish notifications to SNS, and write logs to CloudWatch Logs."
}

# Roleの許可設定
resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role       = aws_iam_role.study_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# S3 Get
resource "aws_iam_role_policy" "inline_policy_s3_get" {
  role = aws_iam_role.study_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.image_upload.arn}/*"
      }
    ]
  })
}

# S3 Put
resource "aws_iam_role_policy" "inline_policy_s3_put" {
  role = aws_iam_role.study_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.image_resized.arn}/*"
      }
    ]
  })
}

# SNS Success
resource "aws_iam_role_policy" "inline_policy_sns_success" {
  role = aws_iam_role.study_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = aws_sns_topic.topic_success.arn
      }
    ]
  })
}

# SNS Failure
resource "aws_iam_role_policy" "inline_policy_sns_failure" {
  role = aws_iam_role.study_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = aws_sns_topic.topic_failure.arn
      }
    ]
  })
}
