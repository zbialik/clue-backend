from pprint import pprint
import boto3
from dynamodb_json import json_util as json

def lambda_handler(event, context):
    
    print('executing create-game lambda function')
    
    dynamodb = boto3.client('dynamodb')
    
    response = dynamodb.put_item(TableName='ClueGames', 
        Item={
            'gameId': {
                'N': '1'
            },
            'hasStarted': {
                'BOOL': False
            },
            'characterName': {
                'S': event['charName']
            },
            'playerName': {
                'S': event['playerName']
            }
        }
    )
    
    return response
