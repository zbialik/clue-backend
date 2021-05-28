from pprint import pprint
import sys
import boto3
import json
from decimal import Decimal
from dynamodb_json import json_util as dynamo_json
from game import Game

def lambda_handler(event, context):
    
    print('executing start-game lambda function')
    db = boto3.resource('dynamodb', region_name='us-east-1')
    table = db.Table('CLUE_GAMES')
    
    # get next gameId code
    try:
        print('activating game ' + str(event['game_id']) + ' now.')
        
        response_dynamo = table.update_item(
            Key={'game_id': event['game_id']},
            UpdateExpression="set #a = :a",
            ExpressionAttributeValues={
                ':a': event['start_game']
            },
            ExpressionAttributeNames={
                "#a": 'active'
            },
            ReturnValues="UPDATED_NEW"
        )
        
        response = dynamo_json.loads(response_dynamo)
        
        if response['ResponseMetadata']['HTTPStatusCode'] == 200:
            print('Succesfully activated game.')
            
            game_dynamo = table.get_item(
                Key={'game_id': event['game_id']}
            )
            
            response = {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                },
                "isBase64Encoded": False,
                "body": dynamo_json.loads(game_dynamo['Item'])
            }
            
            return response
        else:
            print('ERROR: something went wrong while updating "active" attribute for game item (' + str(event['game_id']) + ') in dynamodb.')
            raise
    
    except:
        print("ERROR:", sys.exc_info()[0])
        raise