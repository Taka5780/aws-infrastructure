import io
import os

import boto3
from PIL import Image

MAX_IMAGE_SIZE = 5242880
IMAGE_WIDTH_SIZE = 300
IMAGE_HEIGHT_SIZE = 300
# リサイズ保存先バケットの取得
RESIZED_BUCKET = os.environ["RESIZED_BUCKET_NAME"]
# SNS ARN取得
SUCCESS_TOPIC_ARN = os.environ["SUCCESS_TOPIC_ARN"]
FAILURE_TOPIC_ARN = os.environ["FAILURE_TOPIC_ARN"]


s3 = boto3.client("s3")
sns = boto3.client("sns")


# カスタム例外
class ImageCheckFailed(Exception):
    pass


def lambda_handler(event, context):
    try:
        bucket_name = event["detail"]["bucket"]["name"]
        object_key = event["detail"]["object"]["key"]

        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        status_code = response["ResponseMetadata"]["HTTPStatusCode"]
        if status_code == 200:
            image_type = response["ContentType"]
            image_size = response["ContentLength"]
            image_data = response["Body"].read()

            image_check(image_type, image_size, image_data)
            resized_image = resizing_images(image_data, image_type)
            put_result = save_resized_image_to_s3(resized_image, object_key)
            send_success_sns()
            return put_result

    except ImageCheckFailed:
        send_failure_sns()
        return {"statusCode": 400, "body": "Image check failed. SNS sent."}

    except Exception:
        send_failure_sns()
        return {"statusCode": 500, "body": "System error. SNS sent."}


# 画像検証
def image_check(image_type, image_size, image_data):
    if not image_file_extension_check(image_type):
        raise ImageCheckFailed()

    if not image_size_check(image_size):
        raise ImageCheckFailed()

    if not is_valid_image_data(image_data):
        raise ImageCheckFailed()


# 画像拡張子チェック
def image_file_extension_check(image_type):
    allowed_file_extensions = {"image/png": "png", "image/jpeg": "jpeg"}
    return image_type in allowed_file_extensions


# 画像サイズチェック
def image_size_check(image_size):
    return image_size < MAX_IMAGE_SIZE


# 画像妥当性チェック
def is_valid_image_data(image_data):
    try:
        with Image.open(io.BytesIO(image_data)) as img:
            img.verify()
        return True
    except Exception:
        return False


# 画像のリサイズ
def resizing_images(image_data, image_type):
    with Image.open(io.BytesIO(image_data)) as img:
        img_resized = img.resize((IMAGE_WIDTH_SIZE, IMAGE_HEIGHT_SIZE))
        buffer = io.BytesIO()
        img_resized.save(buffer, format=image_type.split("/")[-1].upper())
        buffer.seek(0)
        return buffer


# リサイズ画像の保存
def save_resized_image_to_s3(resized_image, object_key):
    response = s3.put_object(Bucket=RESIZED_BUCKET, Key=object_key, Body=resized_image)
    status_code = response["ResponseMetadata"]["HTTPStatusCode"]
    return {"statusCode": status_code, "body": "Image put success. SNS sent."}


def send_success_sns():
    sns.publish(
        TopicArn=SUCCESS_TOPIC_ARN,
        Message="画像のリサイズが完了しました。",
        Subject="[Success] 画像リサイズ完了",
    )


def send_failure_sns():
    sns.publish(
        TopicArn=FAILURE_TOPIC_ARN,
        Message="画像のリサイズに失敗しました。",
        Subject="[Failed] 画像リサイズ失敗",
    )
