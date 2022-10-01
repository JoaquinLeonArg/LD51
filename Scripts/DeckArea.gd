extends Node2D



# Imports
const dd = preload("res://Scripts/Classes/DeckData.gd")

# Instance properties
var data: dd.DeckData

# Methods
func _ready():
	var _x
	self.data = dd.DeckData.new()
	_x = self.data.connect("updated_cards", self, "update_text")
	State.state.deck = self

func add_card(card):
	self.data.cards.append(card)
	var old_pos = card.global_position
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	card.global_position = old_pos
	
	card.rest_position = self.global_position
	card.rest_scale = Vector2(1.0, 1.0)
	card.rest_rotation = 0
	card.hover_position = self.global_position
	card.hover_scale = Vector2(1.0, 1.0)
	card.hover_rotation = 0
	card.draggable = false

	card.update_position()

func update_text(card_count):
	$Text.bbcode_text = " DECK (%s)" % card_count