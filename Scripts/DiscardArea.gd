extends Node2D

# Imports

# Properties
var cards = []

# Methods
func _ready():
	State.state.discard = self
	
func add_card(card):
	self.cards.append(card)
	var old_pos = card.global_position
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	card.global_position = old_pos
	card.rest_position = self.global_position
