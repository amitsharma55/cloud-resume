import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("visitor-counter")


def lambda_handler(event, context):
    response = table.update_item(
        Key={"id": "visitor_count"},
        UpdateExpression="SET visit_count = if_not_exists(visit_count, :start) + :inc",
        ExpressionAttributeValues={":inc": Decimal("1"), ":start": Decimal("0")},
        ReturnValues="UPDATED_NEW",
    )

    visitor_count = int(response["Attributes"]["visit_count"])

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type",
        },
        "body": json.dumps({"visitor_count": visitor_count}),
    }
