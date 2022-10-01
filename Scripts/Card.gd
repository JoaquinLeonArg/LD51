extends Node2D

# Signals
signal entered_hand_finished
signal entered_field_finished

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")

# Instance properties
var data: cd.CardData
var enabled: bool = true
var card_index = 0

var dragging: bool = false
var hovering: bool = false

var drag_offset: Vector2

var draggable: bool = false
var rest_scale: Vector2
var hover_scale: Vector2
var rest_position: Vector2
var hover_position: Vector2
var rest_rotation: float
var hover_rotation: float

# Methods
func _ready():
	var _x
	_x = $CardArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $CardArea.connect("mouse_exited", self, "on_mouse_exited")

func _process(delta):
	self.data.update(delta)
	self.update_progress()

func set_data(_data):
	self.data = _data
	$CardArea/CardName.bbcode_text = "[center]%s[/center]" % self.data.name


	var _x
	_x = self.data.connect("entered_field", self, "entered_field")
	_x = self.data.connect("entered_discard", self, "entered_discard")
	_x = self.data.connect("entered_deck", self, "entered_deck")

	_x = self.data.connect("duration_over", self, "duration_over")
	_x = self.data.connect("cooldown_over", self, "cooldown_over")

func _input(event):
	if not self.enabled:
		return
	var tween = create_tween()
	if self.hovering and self.draggable:
		if event.is_action_pressed("left_click"):
			print("Drag")
			self.dragging = true
			self.data.set_active(true)
			self.drag_offset = get_global_mouse_position() - self.global_position
		if event.is_action_released("left_click"):
			print("Drag exit")
			self.dragging = false
			self.data.set_active(false)
			self.enabled = false
			tween.tween_property(self, "global_position", self.rest_position, 0.2)
			tween.tween_property(self, "enabled", true, 0)
	if self.dragging and self.data.zone_data.get_zone() == cd.CardZone.HAND:
		tween.tween_property(self, "global_position", get_global_mouse_position() - self.drag_offset, 0.01)
		tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.2)
		self.rotation = (self.global_position.x - get_global_mouse_position().x + self.drag_offset.x)*0.002

func on_mouse_entered():
	print("Hover")
	var tween = create_tween()
	self.hovering = true
	self.z_index = 1
	if not self.dragging:
		tween.tween_property(self, "scale", self.hover_scale, 0.1)
		tween.tween_property(self, "global_position", self.hover_position, 0.1)
		tween.tween_property(self, "rotation", self.hover_rotation, 0.1)

func on_mouse_exited():
	print("Hover exit")
	var tween = create_tween()
	self.hovering = false
	self.z_index = 0
	tween.tween_property(self, "scale", self.rest_scale, 0.1)
	tween.tween_property(self, "global_position", self.rest_position, 0.1)
	tween.tween_property(self, "rotation", self.rest_rotation, 0.1)

func update_position():
	var tween = create_tween()
	#self.enabled = false
	tween.tween_property(self, "scale", self.rest_scale, 0.2)
	tween.tween_property(self, "global_position", self.rest_position, 0.2)
	tween.tween_property(self, "rotation", self.rest_rotation, 0.2)
	#tween.tween_property(self, "enabled", true, 0.01)

func duration_over():
	$Duration.visible = false

func cooldown_over():
	$Duration.value = 1
	var tween = create_tween()
	tween.tween_property($Duration, "value", 0, self.data.max_cooldown)

func signal_entered_field_finished():
	emit_signal("entered_field_finished")

func update_progress():
	if data.max_duration > 0:
		$Duration.value = data.remaining_duration / data.max_duration
