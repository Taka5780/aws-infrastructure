# Event Bridge
resource "aws_cloudwatch_event_rule" "study_s3_event" {
  name           = "study_event_driven_s3_upload_rule"
  description    = "Triggers the image resize Lambda function when an object is uploaded to the image-upload S3 bucket."
  event_bus_name = "default"
  event_pattern = jsonencode({
    source        = ["aws.s3"]
    "detail-type" = ["Object Created"]
    detail = {
      bucket = {
        name = [aws_s3_bucket.image_upload.id]
      }
    }
  })
}

# Event Target
resource "aws_cloudwatch_event_target" "event_target_lambda" {
  rule           = aws_cloudwatch_event_rule.study_s3_event.name
  event_bus_name = "default"
  arn            = aws_lambda_function.study_event_driven_lambda.arn
}

# 許可設定
resource "aws_lambda_permission" "study_lambda_permission" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.study_event_driven_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.study_s3_event.arn
}
