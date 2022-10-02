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
var is_showing = true

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
	_x = $Front/CardArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $Front/CardArea.connect("mouse_exited", self, "on_mouse_exited")
	_x = $Back/CardArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $Back/CardArea.connect("mouse_exited", self, "on_mouse_exited")


func _process(delta):
	self.data.update(delta)
	self.update_progress()

func set_data(_data):
	self.data = _data
	$Front/CardArea/CardName.bbcode_text = "[center]%s[/center]" % self.data.name


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
			if State.state.current_card:
				var card = State.state.current_card
				card.dragging = false
				State.state.current_card = null
			else:
				#print("Drag")
				self.dragging = true
				State.state.current_card = self
				tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.2)
				self.drag_offset = get_global_mouse_position() - self.global_position
	if self.dragging and self.draggable:
		tween.tween_property(self, "global_position", get_global_mouse_position() - self.drag_offset, 0.01)
		self.rotation = (self.global_position.x - get_global_mouse_position().x + self.drag_offset.x)*0.002

func on_mouse_entered():
	var tween = create_tween()
	self.hovering = true
	self.z_index = 1
	tween.tween_property(self, "scale", self.hover_scale, 0.1)
	tween.tween_property(self, "global_position", self.hover_position, 0.1)
	tween.tween_property(self, "rotation", self.hover_rotation, 0.1)

func on_mouse_exited():
	var tween = create_tween()
	self.hovering = false
	self.z_index = 0
	tween.tween_property(self, "scale", self.rest_scale, 0.1)
	tween.tween_property(self, "global_position", self.rest_position, 0.1)
	tween.tween_property(self, "rotation", self.rest_rotation, 0.1)

func update_position():
	var tween = create_tween()
	if not tween:
		return
		# WTF
	#self.enabled = false
	tween.tween_property(self, "scale", self.rest_scale, 0.2)
	tween.tween_property(self, "global_position", self.rest_position, 0.2)
	tween.tween_property(self, "rotation", self.rest_rotation, 0.2)
	#tween.tween_property(self, "enabled", true, 0.01)

func duration_over():
	$Front/Duration.visible = false

func cooldown_over():
	$Front/Duration.value = 1
	var tween = create_tween()
	tween.tween_property($Duration, "value", 0, self.data.max_cooldown)

func signal_entered_field_finished():
	emit_signal("entered_field_finished")

func update_progress():
	if data.max_duration > 0:
		$Front/Duration.value = data.remaining_duration / data.max_duration

func flip(duration: float):
	#print(self.is_showing)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0, self.scale.y), duration)
	if self.is_showing:
		tween.tween_property($Back, "visible", true, 0)
		tween.tween_property($Front, "visible", false, 0)
	else:
		tween.tween_property($Back, "visible", false, 0)
		tween.tween_property($Front, "visible", true, 0)
	tween.tween_property(self, "scale", Vector2(1, self.scale.y), duration)
	self.is_showing = not self.is_showing