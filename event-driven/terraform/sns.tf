# Topic Success
resource "aws_sns_topic" "topic_success" {
  fifo_topic = false
  name       = "Success"
}

# Success Subscription
resource "aws_sns_topic_subscription" "success_subscription" {
  topic_arn = aws_sns_topic.topic_success.arn
  protocol  = "email"
  endpoint  = var.endpoint
}

# Topic Failure
resource "aws_sns_topic" "topic_failure" {
  fifo_topic = false
  name       = "Failure"
}

# Failure Subscription
resource "aws_sns_topic_subscription" "failure_subscription" {
  topic_arn = aws_sns_topic.topic_failure.arn
  protocol  = "email"
  endpoint  = var.endpoint
}
