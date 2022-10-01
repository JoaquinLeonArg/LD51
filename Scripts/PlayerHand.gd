extends Node2D

# Constants
const CARD_COUNT: int = 5
const CARD_OFFSET_X: int = 112
const CARD_OFFSET_Y: int = 16
const MAX_DISTANCE_X: int = 600
const MAX_DISTANCE_Y: int = 20
const CARD_SPACING_X: int = 100
const ROTATION_RATE: float = 0.12

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const hd = preload("res://Scripts/Classes/HandData.gd")
const content_cards = preload("res://Scripts/Content/Cards.gd")
const card_component = preload("res://Components/Card.tscn")

# Instance properties
var data: hd.HandData

# Methods
func _ready():
	State.state.hand = self
	self.data = hd.HandData.new()

func update_card_positions():
	for i in range(len(self.data.cards)):
		var card = self.data.cards[i]
		card.card_index = i
		var center_factor
		if len(self.data.cards) != 1:
			center_factor = (i / (float(len(self.data.cards)) - 1)) - 0.5
		else:
			center_factor = 0.0
		var position = Vector2.ZERO
		position.x = center_factor * min(MAX_DISTANCE_X, CARD_SPACING_X*len(self.data.cards))
		position.y = abs(center_factor) * MAX_DISTANCE_Y
		position += self.global_position

		card.rest_rotation = center_factor * ROTATION_RATE
		card.rest_position = position
		card.rest_scale = Vector2(1.0, 1.0)
		card.hover_rotation = 0
		card.hover_position = position + Vector2(0, -35)
		card.hover_scale = Vector2(1.3, 1.3)
		card.draggable = false

		card.update_position()
		

func add_card(card: Node2D):
	self.data.cards.append(card)
	var old = card.global_position
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	card.global_position = old
	self.update_card_positions()

func remove_card(card: Node2D):
	self.remove_child(card)
	self.update_card_positions()
	self.data.cards.erase(card)

func _process(_delta):
	self.debug_process()

func debug_process():
	if Input.is_action_just_pressed("ui_up"):
		State.state.start_game()