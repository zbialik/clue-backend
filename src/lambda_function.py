from pprint import pprint
import sys
import boto3
import json
from decimal import Decimal
from dynamodb_json import json_util as dynamo_json
from game import Game

def lambda_handler(event, context):
    
    print('executing create-game lambda function')
    db = boto3.resource('dynamodb', region_name='us-east-1')
    table = db.Table('CLUE_GAMES')
    
    # get next gameId code
    try:
        counter_item_dynamo = table.get_item(Key={'game_id': 1})
        
        counter_item = dynamo_json.loads(counter_item_dynamo['Item'])
        table_item_count = counter_item['counter']
        print('Number of items in CLUE_GAMES table: ' + str(table_item_count))
        
        newGameId = table_item_count + 1
        print('Next gameId is: ' + str(newGameId))
        
        newGame = Game(newGameId)
        
        # Add New Game Item to Table
        create_game_response_dynamo = table.put_item(
            Item=newGame.__dict__
        )
        
        create_game_response = dynamo_json.loads(create_game_response_dynamo)
        
        # Check Status Code of Put Item is 200
        if create_game_response['ResponseMetadata']['HTTPStatusCode'] == 200:
            print('Put Item was succesful in dynamodb. Incrementing game counter item now.')
            
            response_dynamo = table.update_item(
                Key={'game_id': 1},
                UpdateExpression="set #c = #c + :inc",
                ExpressionAttributeValues={
                    ':inc': 1
                },
                ExpressionAttributeNames={
                    "#c": "counter"
                },
                ReturnValues="UPDATED_NEW"
            )
            
            response = dynamo_json.loads(response_dynamo)
            
            if response['ResponseMetadata']['HTTPStatusCode'] == 200:
                print('Succesfully updated game counter.')
            else:
                print('Something went wrong while updating game counter item in dynamodb.')
        else: 
            print('Something messed up while putting new Game item in dynamodb.')
        
        response = {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "isBase64Encoded": False,
            "body": newGame.__dict__
        }
        
        return response
    
    except:
        print("ERROR:", sys.exc_info()[0])
        raise