data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# バケット作成
resource "aws_s3_bucket" "image_upload" {
  bucket_namespace = "account-regional"
  /* account-regional で bucket_prefix を使用すると、
     Terraformのランダム文字列付与によりバケット名が63文字を超えるため、完全なバケット名を明示する */
  bucket = format(
    "image-upload-%s-%s-an",
    data.aws_caller_identity.current.account_id,
    data.aws_region.current.region
  )
  # 検証環境のため、terraform destroy時にテストデータも削除する
  force_destroy       = true
  object_lock_enabled = false
}

resource "aws_s3_bucket" "image_resized" {
  bucket_namespace = "account-regional"
  /* account-regional で bucket_prefix を使用すると、
     Terraformのランダム文字列付与によりバケット名が63文字を超えるため、完全なバケット名を明示する */
  bucket = format(
    "image-resized-%s-%s-an",
    data.aws_caller_identity.current.account_id,
    data.aws_region.current.region
  )
  # 検証環境のため、terraform destroy時にテストデータも削除する
  force_destroy       = true
  object_lock_enabled = false
}

# オブジェクト所有者
resource "aws_s3_bucket_ownership_controls" "image_upload_ownership" {
  bucket = aws_s3_bucket.image_upload.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_ownership_controls" "image_resized_ownership" {
  bucket = aws_s3_bucket.image_resized.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# パブリックアクセス
resource "aws_s3_bucket_public_access_block" "image_upload_public_access_block" {
  bucket                  = aws_s3_bucket.image_upload.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "image_resized_public_access_block" {
  bucket                  = aws_s3_bucket.image_resized.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# バージョニング
resource "aws_s3_bucket_versioning" "image_upload_versioning" {
  bucket = aws_s3_bucket.image_upload.id
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "image_resized_versioning" {
  bucket = aws_s3_bucket.image_resized.id
  versioning_configuration {
    status = "Suspended"
  }
}

# 暗号化タイプ
resource "aws_s3_bucket_server_side_encryption_configuration" "image_upload_encryption" {
  bucket = aws_s3_bucket.image_upload.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "image_resized_encryption" {
  bucket = aws_s3_bucket.image_resized.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# ライフサイクル
resource "aws_s3_bucket_lifecycle_configuration" "image_upload_lifecycle" {
  bucket = aws_s3_bucket.image_upload.id
  rule {
    id     = "delete-upload-images"
    status = "Enabled"
    # バケット内のすべてのオブジェクトに適用
    filter {}
    expiration {
      days = 7
    }
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "image_resized_lifecycle" {
  bucket = aws_s3_bucket.image_resized.id
  rule {
    id     = "delete-resized-images"
    status = "Enabled"
    # バケット内のすべてのオブジェクトに適用
    filter {}
    expiration {
      days = 7
    }
  }
}

# EventBridge Notification
resource "aws_s3_bucket_notification" "event_notification" {
  bucket      = aws_s3_bucket.image_upload.id
  eventbridge = true
}
