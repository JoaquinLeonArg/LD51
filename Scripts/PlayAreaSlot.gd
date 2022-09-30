extends Node2D

# Constants


# Imports
const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

# Instance properties
var card
var slot_index = 0
var hovering: bool = false
var data: psd.PlaySlotData = psd.PlaySlotData.new(psd.SlotType.SLOT_A, 0)

func _input(event):
	if not self.hovering:
		return
	if event.is_action_released("left_click"):
		if State.state.current_card:
			self.card = State.state.current_card
			self.card.entered_field(self)

func _process(_delta):
	if self.is_mouse_hovering():
		self.hovering = true
		self.modulate = Color(1, 0.5, 0.3, 1)
	else:
		self.hovering = false
		self.modulate = Color(1, 1, 1, 1)

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.global_position.x) < 128,
		(get_global_mouse_position().y - self.global_position.y) < 196,
		(get_global_mouse_position().x - self.global_position.x) > 0,
		(get_global_mouse_position().y - self.global_position.y) > 0
	].count(true) == 4
