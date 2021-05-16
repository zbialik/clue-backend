class Player(Character):

  def __init__(self, is_first, playerName, character_name, home):
        super().__init__(character_name, home)
        self.playerName = playerName
        self.is_first = is_first
        self.is_turn = False
        self.event_message = "Welcome to Clue!"
        self.state = None
        self.possible_moves = []
        self.hand_cards = []
        self.known_cards = []
        self.revealed_clue = None
