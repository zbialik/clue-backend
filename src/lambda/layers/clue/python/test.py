from game import Game

ng = Game(1)
ng.add_player('colonel mustard', 'Zach')

print(ng.to_json())