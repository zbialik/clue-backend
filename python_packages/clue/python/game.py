import player
import character
import clue_constants

class Game(ClueConstants):

  def __init__(self, game_id):
        self.active = False
        self.game_id = game_id
        self.myster_cards = []
        self.suggestion_cards = []
        self.event_message = ""
        self.character_map = {}
