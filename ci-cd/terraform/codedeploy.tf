# CodeDeploy
resource "aws_codedeploy_app" "study_app" {
  name             = "study_app"
  compute_platform = "Server"
}

# CodeDeploy group
resource "aws_codedeploy_deployment_group" "study_deploy_group" {
  app_name              = aws_codedeploy_app.study_app.name
  deployment_group_name = "study_deploy_group"
  service_role_arn      = aws_iam_role.study_code_deploy_role.arn
  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "study-web"
  }

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
