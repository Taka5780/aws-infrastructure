# CodePipeline用 S3バケット
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "pipeline_bucket" {
  bucket        = "study-codepipeline-artifacts-bucket-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

# CodePipeline
resource "aws_codepipeline" "study_code_pipeline" {
  name          = "study_code_pipeline"
  role_arn      = aws_iam_role.pipeline.arn
  pipeline_type = "V2"

  artifact_store {
    location = aws_s3_bucket.pipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codeconnections_connection.github.arn
        FullRepositoryId = "Taka5780/aws-infrastructure"
        BranchName       = "main"
        DetectChanges    = "true"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]

      configuration = {
        ProjectName = aws_codebuild_project.study_code_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["BuildArtifact"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.study_app.name
        DeploymentGroupName = aws_codedeploy_deployment_group.study_deploy_group.deployment_group_name
      }
    }
  }
}
