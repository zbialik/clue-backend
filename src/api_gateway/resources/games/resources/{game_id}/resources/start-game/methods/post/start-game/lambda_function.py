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
    
    # get path params
    game_id = event['pathParameters']['game_id']

    # get query params
    start_game = event["queryStringParameters"]['start_game']
    
    try:
        print('starting game ' + str(game_id) + ' now.')
        
        response_dynamo = table.update_item(
            Key={'game_id': str(game_id)},
            UpdateExpression="set #a = :a",
            ExpressionAttributeValues={
                ':a': start_game
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
                Key={'game_id': str(game_id)}
            )
            game_dict = dynamo_json.loads(game_dynamo)
            
            response = {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                },
                "isBase64Encoded": False,
                "body": json.dumps(game_dict)
            }
            
            return response
        else:
            print('ERROR: something went wrong while updating "active" attribute for game item (' + str('game_id') + ') in dynamodb.')
            raise
    
    except:
        print("ERROR:", sys.exc_info()[0])
        raise