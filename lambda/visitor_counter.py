import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('c-r-c')

def lambda_handler(event, context):
    
    response = table.get_item(
        Key = {
            'ID':'visits'
        }
    )
    #print(response)
    visit_count = response['Item']['counter'] 
    visit_count = str(int(visit_count) + 1)
    
    response = table.put_item(
        Item = {
            'ID':'visits',
            'counter': visit_count
        }
    )

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS,POST'
        },
        #'body': visit_count
        'body': json.dumps({'visit_count': visit_count})
    }
