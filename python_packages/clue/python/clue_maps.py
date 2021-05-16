import json
import clue_constants
from card import Card 

# Define Character Turn Order
CHARACTER_TURN_ORDER = [
    clue_constants.CHARACTER_NAME_MISS_SCARLET,
    clue_constants.CHARACTER_NAME_COLONEL_MUSTARD,
    clue_constants.CHARACTER_NAME_MRS_WHITE,
    clue_constants.CHARACTER_NAME_MR_GREEN,
    clue_constants.CHARACTER_NAME_MRS_PEACOCK,
    clue_constants.CHARACTER_NAME_PROF_PLUM
]

# Define Card Map
def init_card_map(): 
    card_map = {}
    
    # add weapon cards
    card_map[clue_constants.WEAPON_NAME_KNIFE] = json.dumps(Card(clue_constants.WEAPON_NAME_KNIFE, clue_constants.CARD_TYPE_WEAPON).__dict__)
    card_map[clue_constants.WEAPON_NAME_REVOLVER] = json.dumps(Card(clue_constants.WEAPON_NAME_REVOLVER, clue_constants.CARD_TYPE_WEAPON).__dict__)
    card_map[clue_constants.WEAPON_NAME_ROPE] = json.dumps(Card(clue_constants.WEAPON_NAME_ROPE, clue_constants.CARD_TYPE_WEAPON).__dict__)
    card_map[clue_constants.WEAPON_NAME_WRENCH] = json.dumps(Card(clue_constants.WEAPON_NAME_WRENCH, clue_constants.CARD_TYPE_WEAPON).__dict__)
    card_map[clue_constants.WEAPON_NAME_CANDLESTICK] = json.dumps(Card(clue_constants.WEAPON_NAME_CANDLESTICK, clue_constants.CARD_TYPE_WEAPON).__dict__)
    card_map[clue_constants.WEAPON_NAME_LEADPIPE] = json.dumps(Card(clue_constants.WEAPON_NAME_LEADPIPE, clue_constants.CARD_TYPE_WEAPON).__dict__)

    # add room cards
    card_map[clue_constants.LOCATION_NAME_BALL_ROOM] = json.dumps(Card(clue_constants.LOCATION_NAME_BALL_ROOM, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_BILLIARD_ROOM] = json.dumps(Card(clue_constants.LOCATION_NAME_BILLIARD_ROOM, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_CONSERVATORY] = json.dumps(Card(clue_constants.LOCATION_NAME_CONSERVATORY, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_DINING_ROOM] = json.dumps(Card(clue_constants.LOCATION_NAME_DINING_ROOM, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_HALL] = json.dumps(Card(clue_constants.LOCATION_NAME_HALL, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_KITCHEN] = json.dumps(Card(clue_constants.LOCATION_NAME_KITCHEN, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_LOUNGE] = json.dumps(Card(clue_constants.LOCATION_NAME_LOUNGE, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_LIBRARY] = json.dumps(Card(clue_constants.LOCATION_NAME_LIBRARY, clue_constants.CARD_TYPE_ROOM).__dict__)
    card_map[clue_constants.LOCATION_NAME_STUDY] = json.dumps(Card(clue_constants.LOCATION_NAME_STUDY, clue_constants.CARD_TYPE_ROOM).__dict__)

    # add suspect cards
    card_map[clue_constants.CHARACTER_NAME_MRS_WHITE] = json.dumps(Card(clue_constants.CHARACTER_NAME_MRS_WHITE, clue_constants.CARD_TYPE_SUSPECT).__dict__)
    card_map[clue_constants.CHARACTER_NAME_MR_GREEN] = json.dumps(Card(clue_constants.CHARACTER_NAME_MR_GREEN, clue_constants.CARD_TYPE_SUSPECT).__dict__)
    card_map[clue_constants.CHARACTER_NAME_MRS_PEACOCK] = json.dumps(Card(clue_constants.CHARACTER_NAME_MRS_PEACOCK, clue_constants.CARD_TYPE_SUSPECT).__dict__)
    card_map[clue_constants.CHARACTER_NAME_PROF_PLUM] = json.dumps(Card(clue_constants.CHARACTER_NAME_PROF_PLUM, clue_constants.CARD_TYPE_SUSPECT).__dict__)
    card_map[clue_constants.CHARACTER_NAME_MISS_SCARLET] = json.dumps(Card(clue_constants.CHARACTER_NAME_MISS_SCARLET, clue_constants.CARD_TYPE_SUSPECT).__dict__)
    card_map[clue_constants.CHARACTER_NAME_COLONEL_MUSTARD] = json.dumps(Card(clue_constants.CHARACTER_NAME_COLONEL_MUSTARD, clue_constants.CARD_TYPE_SUSPECT).__dict__)

    return card_map