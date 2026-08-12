data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../app/lambda"
  output_path = "${path.module}/lambda.zip"
}

# Lambda
resource "aws_lambda_function" "study_event_driven_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "study_event_driven_image_resize"
  role          = aws_iam_role.study_lambda_role.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.12"
  memory_size   = 256
  timeout       = 15

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      RESIZED_BUCKET_NAME = aws_s3_bucket.image_resized.id
      SUCCESS_TOPIC_ARN   = aws_sns_topic.topic_success.arn
      FAILURE_TOPIC_ARN   = aws_sns_topic.topic_failure.arn
    }
  }

  layers = [aws_lambda_layer_version.study_lambda_layer.arn]
}

# Lambda Layer
resource "aws_lambda_layer_version" "study_lambda_layer" {
  layer_name               = "study_event_driven_pillow_layer"
  description              = "Provides the Pillow library for image processing in the Lambda function."
  filename                 = "${path.module}/../pillow-layer/pillow-layer.zip"
  compatible_architectures = ["x86_64"]
  compatible_runtimes      = ["python3.12"]
  source_code_hash         = filebase64sha256("${path.module}/../pillow-layer/pillow-layer.zip")
}
