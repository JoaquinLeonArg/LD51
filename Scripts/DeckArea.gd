extends Node2D



# Imports
const dd = preload("res://Scripts/Classes/DeckData.gd")

# Instance properties
var data: dd.DeckData

# Methods
func _ready():
	var _x
	self.data = dd.DeckData.new()
	State.state.deck = self
