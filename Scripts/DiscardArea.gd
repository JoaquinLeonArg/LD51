extends Node2D

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const dd = preload("res://Scripts/Classes/DiscardData.gd")

# Properties
var data: dd.DiscardData
var count: int = 0

# Methods
func _ready():
	State.state.discard = self
	self.data = dd.DiscardData.new()
	var _x
	_x = self.data.connect("updated_cards", self, "update_text")
	
func add_card(card):
	Sound.sound.play_effect("discard_card")
	self.data.add_card(card)
	var old_pos = card.global_position
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	card.global_position = old_pos

	card.rest_rotation = 0
	card.rest_position = self.global_position
	card.rest_scale = Vector2(1.0, 1.0)
	card.hover_rotation = 0
	card.hover_position = self.global_position
	card.hover_scale = Vector2(1.0, 1.0)
	card.draggable = false

	card.data.zone_data = cd.DiscardCardZoneData.new()

	card.update_position()

func update_text():
	self.count = len(self.data.cards)
	$Text.bbcode_text = " DISCARD (%s)" % self.count
