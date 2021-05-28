from player import Player
import clue_constants as clue
from clue_helpers import *

class Game():

  def __init__(self, game_id):
    self.active = False
    self.game_id = game_id
    self.mystery_cards = []
    self.suggestion_cards = []
    self.event_message = ""
    self.character_map = init_character_map()
  
  # return JSON String for Game object
  def to_json(self):
    return json.dumps(self, default=lambda x: x.__dict__, indent=4)

  def has_player(self):
    for character in self.character_map.values():
      if isinstance(character, Player):
        return True
    return False

  def add_player(self, character_name, player_name):
    desired_character = self.character_map.get(character_name)
    if isinstance(desired_character, Player):
      print("Sorry, the character is already selected. Please select another character.")
    
    # TODO: check if character exists in map
    
    else:
        character_home = self.character_map.get(character_name).get('home')
        new_player = {
          character_name: Player(not self.has_player(), player_name, character_name, character_home)
        }
        self.character_map.update(new_player)


  