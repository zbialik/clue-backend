from player import Player
import clue_constants as clue
from clue_maps import *

class Game():

  def __init__(self, game_id):
        self.active = False
        self.game_id = game_id
        self.myster_cards = []
        self.suggestion_cards = []
        self.event_message = ""
        self.character_map = init_character_map()
