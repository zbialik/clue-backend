from character import Character

class Player(Character):

  def __init__(self, is_first, player_name, character_name, home):
        super().__init__(character_name, home)
        # super(character_name, home)
        self.player_name = player_name
        self.is_first = is_first
        self.is_turn = False
        self.event_message = "Welcome to Clue!"
        self.state = None
        self.possible_moves = []
        self.hand_cards = []
        self.known_cards = []
        self.revealed_clue = None
