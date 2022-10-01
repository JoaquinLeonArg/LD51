extends Node2D

# Signals
signal entered_hand_finished
signal entered_field_finished

# Enums
enum Status {ON_HAND, ON_FIELD}

# Constants


# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")

# Instance properties
var data: cd.CardData
var enabled: bool = true
var card_index = 0
var dragging: bool = false
var hovering: bool = false
var drag_offset: Vector2
var rest_position: Vector2
var rest_rotation: float
var status: int = Status.ON_HAND

# Methods
func _ready():
	var _x
	_x = $CardArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $CardArea.connect("mouse_exited", self, "on_mouse_exited")

	_x = self.data.connect("entered_field", self, "entered_field")
	# var card_data = cd.CardDataProperties.new()
	# card_data.behaviors = [cd.CardBehavior]
	# self.data = cd.CardData.new(card_data)
	# self.data.play()

func _input(event):
	if not self.enabled:
		return
	if self.hovering and self.status == Status.ON_HAND:
		if event.is_action_pressed("left_click"):
			self.dragging = true
			self.data.set_active(true)
			self.drag_offset = get_global_mouse_position() - self.global_position
		if event.is_action_released("left_click"):
			self.dragging = false
			self.data.set_active(false)
			self.enabled = false
			var tween = create_tween()
			tween.tween_property(self, "global_position", self.rest_position, 0.2)
			tween.tween_property(self, "enabled", true, 0)
	if self.dragging and self.status == Status.ON_HAND:
		var tween = create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position() - self.drag_offset, 0.01)
		self.rotation = (self.global_position.x - get_global_mouse_position().x + self.drag_offset.x)*0.002

func on_mouse_entered():
	var tween = create_tween()
	self.hovering = true
	self.z_index = 1
	if not self.dragging and self.status == Status.ON_HAND:
		tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)
		tween.tween_property(self, "global_position", Vector2(self.global_position.x, self.rest_position.y - 55), 0.2)
		tween.tween_property(self, "rotation", 0.0, 0.05)
	if self.status == Status.ON_FIELD:
		tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)

func on_mouse_exited():
	var tween = create_tween()
	self.hovering = false
	self.z_index = 0
	if self.status == Status.ON_HAND:
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
		tween.tween_property(self, "global_position", self.rest_position, 0.2)
		tween.tween_property(self, "rotation", self.rest_rotation, 0.2)
	if self.status == Status.ON_FIELD:
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func entered_field(slot):
	var tween = create_tween()
	self.rest_position = slot.global_position
	var current_pos = self.global_position
	self.get_parent().remove_child(self)
	State.state.field.add_child(self)
	self.global_position = current_pos
	tween.tween_property(self, "global_position", slot.global_position + $CardArea.rect_pivot_offset, 0.1)
	tween.tween_property(self, "rotation", 0, 0)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0)
	tween.tween_callback(self, "signal_entered_field_finished")
	self.status = Status.ON_FIELD

func signal_entered_field_finished():
	emit_signal("entered_field_finished")
