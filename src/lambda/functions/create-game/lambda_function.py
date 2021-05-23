from pprint import pprint
import sys
import boto3
import json
from decimal import Decimal
from dynamodb_json import json_util as dynamo_json
# from game import Game
from uuid import uuid4

def lambda_handler(event, context):
    
    print('executing create-game lambda function')
    db = boto3.resource('dynamodb', region_name='us-east-1')
    table = db.Table('CLUE_GAMES')
    
    # get next gameId code
    try:
        
        # Generate Game UUID
        new_game_id = str(uuid4())
        print('Next new_game_id is: ' + new_game_id)
        
        new_game = Game(new_game_id)
        
        # Add New Game Item to Table
        create_game_response_dynamo = table.put_item(
            Item=new_game.__dict__
        )
        
        create_game_response = dynamo_json.loads(create_game_response_dynamo)
        
        # Check Status Code of Put Item is 200
        if create_game_response['ResponseMetadata']['HTTPStatusCode'] == 200:
            print('Put Item was succesful in dynamodb. Incrementing game counter item now.')
        else: 
            print('Something messed up while putting new Game item in dynamodb.')
            raise
        
        response = {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "isBase64Encoded": False,
            "body": new_game.__dict__
        }
        
        return response
    
    except:
        print("ERROR:", sys.exc_info()[0])
        raise