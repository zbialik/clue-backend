import json
from clue_constants import ClueConstants as clue

class ClueConstantMapLists(clue):

    # Define Character Turn Order
    CHARACTER_TURN_ORDER = [
        clue.CHARACTER_NAME_MISS_SCARLET,
        clue.CHARACTER_NAME_COLONEL_MUSTARD,
        clue.CHARACTER_NAME_MRS_WHITE,
        clue.CHARACTER_NAME_MR_GREEN,
        clue.CHARACTER_NAME_MRS_PEACOCK,
        clue.CHARACTER_NAME_PROF_PLUM
    ]

    # Define Card Map
    # TODO: FIX THIS SECTION
    def init_card_map(): 
        card_map = {}
        
        # add weapon cards
        card_map[clue.WEAPON_NAME_KNIFE] = Card(clue.WEAPON_NAME_KNIFE, clue.CARD_TYPE_WEAPON)
        card_map[clue.WEAPON_NAME_REVOLVER] = Card(clue.WEAPON_NAME_REVOLVER, clue.CARD_TYPE_WEAPON)
        card_map[clue.WEAPON_NAME_ROPE] = Card(clue.WEAPON_NAME_ROPE, clue.CARD_TYPE_WEAPON)
        card_map[clue.WEAPON_NAME_WRENCH] = Card(clue.WEAPON_NAME_WRENCH, clue.CARD_TYPE_WEAPON)
        card_map[clue.WEAPON_NAME_CANDLESTICK] = Card(clue.WEAPON_NAME_CANDLESTICK, clue.CARD_TYPE_WEAPON)
        card_map[clue.WEAPON_NAME_LEADPIPE] = Card(clue.WEAPON_NAME_LEADPIPE, clue.CARD_TYPE_WEAPON)

        # add room cards
        card_map[clue.LOCATION_NAME_BALL_ROOM] = Card(clue.LOCATION_NAME_BALL_ROOM, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_BILLIARD_ROOM] = Card(clue.LOCATION_NAME_BILLIARD_ROOM, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_CONSERVATORY] = Card(clue.LOCATION_NAME_CONSERVATORY, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_DINING_ROOM] = Card(clue.LOCATION_NAME_DINING_ROOM, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_HALL] = Card(clue.LOCATION_NAME_HALL, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_KITCHEN] = Card(clue.LOCATION_NAME_KITCHEN, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_LOUNGE] = Card(clue.LOCATION_NAME_LOUNGE, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_LIBRARY] = Card(clue.LOCATION_NAME_LIBRARY, clue.CARD_TYPE_ROOM)
        card_map[clue.LOCATION_NAME_STUDY] = Card(clue.LOCATION_NAME_STUDY, clue.CARD_TYPE_ROOM)

        # add suspect cards
        card_map[clue.CHARACTER_NAME_MRS_WHITE] = Card(clue.CHARACTER_NAME_MRS_WHITE, clue.CARD_TYPE_SUSPECT)
        card_map[clue.CHARACTER_NAME_MR_GREEN] = Card(clue.CHARACTER_NAME_MR_GREEN, clue.CARD_TYPE_SUSPECT)
        card_map[clue.CHARACTER_NAME_MRS_PEACOCK] = Card(clue.CHARACTER_NAME_MRS_PEACOCK, clue.CARD_TYPE_SUSPECT)
        card_map[clue.CHARACTER_NAME_PROF_PLUM] = Card(clue.CHARACTER_NAME_PROF_PLUM, clue.CARD_TYPE_SUSPECT)
        card_map[clue.CHARACTER_NAME_MISS_SCARLET] = Card(clue.CHARACTER_NAME_MISS_SCARLET, clue.CARD_TYPE_SUSPECT)
        card_map[clue.CHARACTER_NAME_COLONEL_MUSTARD] = Card(clue.CHARACTER_NAME_COLONEL_MUSTARD, clue.CARD_TYPE_SUSPECT)

        return card_map