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
    
    # get game
    try:
        print('retriving game ' + str(event['game_id']) + ' from dynamodb ')
        game_item_dynamo = table.get_item(Key={'game_id': event['game_id']})
        
        game_item = dynamo_json.loads(game_item_dynamo['Item'])
        
        response = {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "isBase64Encoded": False,
            "body": game_item
        }
        
        return response
        
    except:
        print("ERROR:", sys.exc_info()[0])
        raise