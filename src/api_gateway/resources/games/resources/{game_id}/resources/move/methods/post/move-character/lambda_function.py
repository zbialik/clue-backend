from pprint import pprint
import sys
import boto3
import json
from decimal import Decimal
from dynamodb_json import json_util as dynamo_json
from game import Game

def lambda_handler(event, context):
    
    print('executing move-character lambda function')
    db = boto3.resource('dynamodb', region_name='us-east-1')
    table = db.Table('CLUE_GAMES')
    
    # get path params
    game_id = event['pathParameters']['game_id']

    # get query params
    # start_game = event["queryStringParameters"]['start_game']
    
    try:
        print('moving character in game ' + str(game_id) + ' now.')

        # TODO: Validate Response

        # TODO: Update Character Location
    
    except:
        print("ERROR:", sys.exc_info()[0])
        raise