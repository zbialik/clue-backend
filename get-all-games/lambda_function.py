from pprint import pprint
import boto3
import json
from dynamodb_json import json_util as dynamo_json

def lambda_handler(event, context):
    
    print('executing get-all-games lambda function')
    
    dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
    
    table = dynamodb.Table('ClueGames')
    
    print('Beginning scan of dynamodb table: ClueGames')
    response = table.scan()
    data = response['Items']
    while 'LastEvaluatedKey' in response:
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        data.extend(response['Items'])
    
    print('converting dynamodb json to python dict -> dynamo_dict')
    dynamo_dict = dynamo_json.loads(data)
    print('json.dumps(dynamo_dict): ' + json.dumps(dynamo_dict))
    
    response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "isBase64Encoded": False,
        "body": json.dumps(dynamo_dict)
    }
    
    return response
