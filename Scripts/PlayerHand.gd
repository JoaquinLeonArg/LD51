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
const content_cards = preload("res://Scripts/Content/Cards.gd")
const card_component = preload("res://Components/Card.tscn")

# Instance properties
var cards: Array = [] # <Card>

# Methods
func _ready():
	State.state.hand = self
	for _i in range(CARD_COUNT):
		var card_props = content_cards.CardTest.new()
		var card = card_component.instance()
		card.set_data(cd.CardData.new(card_props))
		card.data.ui_owner = card
		card.owner = self
		card.data.zone_data = cd.HandCardZoneData.new(_i)
		self.add_card(card)

func update_card_positions():
	for i in range(len(self.cards)):
		var card = self.cards[i]
		card.card_index = i
		var center_factor
		if len(self.cards) != 1:
			center_factor = (i / (float(len(self.cards)) - 1)) - 0.5
		else:
			center_factor = 0.0
		card.position.x = center_factor * min(MAX_DISTANCE_X, CARD_SPACING_X*len(self.cards))
		card.position.y = abs(center_factor) * MAX_DISTANCE_Y
		card.rotation = center_factor * ROTATION_RATE
		card.rest_position = card.global_position
		card.rest_rotation = card.rotation

func add_card(card: Node2D):
	self.cards.append(card)
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	self.update_card_positions()

func _process(_delta):
	self.debug_process()

func debug_process():
	if Input.is_action_just_pressed("ui_up"):
		self.add_card(null)
	if Input.is_action_just_pressed("ui_down"):
		var card = self.cards.pop_back()
		card.queue_free()
		self.update_card_positions()
