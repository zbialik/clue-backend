from pprint import pprint
import sys
import boto3
import json
from decimal import Decimal
from dynamodb_json import json_util as dynamo_json
from game import Game

def lambda_handler(event, context):
    
    print('executing get-game lambda function')
    db = boto3.resource('dynamodb', region_name='us-east-1')
    table = db.Table('CLUE_GAMES')
    
    # get game id
    game_id = event['pathParameters']['game_id']
    
    try:
        # print('event: ' + json.dumps(event))
        print('retriving game ' + str(game_id) + ' from dynamodb ')

        # get game from dynamodb using game_id path param
        game_dynamo = table.get_item(Key={'game_id': game_id})
        
        game_dict = dynamo_json.loads(game_dynamo['Item'])
        
        response = {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "isBase64Encoded": False,
            "body": json.dumps(game_dict)
        }
        
        return response
        
    except:
        print("ERROR:", sys.exc_info()[0])
        raise