class Character:

  def __init__(self, character_name, home):
        self.character_name = character_name
        self.home = home
        self.current_location = home
        self.wasMovedToRoom = False
        self.active = False
