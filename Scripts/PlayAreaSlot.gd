extends Node2D

# Constants


# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

# Instance properties
var card = null
var slot_index = 0
var hovering: bool = false
var data: psd.PlaySlotData = null

func _input(event):
	if not self.hovering:
		return
	if event.is_action_released("left_click"):
		if State.state.current_card and State.state.current_card.data.type == cd.CardType.BUILDING and not self.card:
			self.card = State.state.current_card
			State.state.current_card = null
			
			var old_pos = self.card.global_position
			if self.card.get_parent():
				self.card.get_parent().remove_child(self.card)
			self.add_child(self.card)
			self.card.global_position = old_pos

			self.card.rest_rotation = 0
			self.card.rest_position = self.global_position
			self.card.rest_scale = Vector2(1.0, 1.0)
			self.card.hover_rotation = 0
			self.card.hover_position = self.global_position
			self.card.hover_scale = Vector2(1.2, 1.2)
			self.card.draggable = false

			self.card.dragging = false

			card.data.zone_data = cd.FieldCardZoneData.new(self.slot_index)

			State.state.hand.remove_card(self.card)
			self.card.update_position()
			return
		if State.state.current_card and self.card:
			var curr_card = State.state.current_card
			curr_card.dragging = false
			State.state.current_card = null


func _process(_delta):
	if self.is_mouse_hovering() and State.state.current_card:
		if State.state.current_card.data.type == cd.CardType.BUILDING:
			self.hovering = true
			self.modulate = Color(1, 0.5, 0.3, 1)
	else:
		self.hovering = false
		self.modulate = Color(1, 1, 1, 0.2)

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.global_position.x + 64) < 128,
		(get_global_mouse_position().y - self.global_position.y + 152) < 196,
		(get_global_mouse_position().x - self.global_position.x + 64) > 0,
		(get_global_mouse_position().y - self.global_position.y + 152) > 0
	].count(true) == 4
