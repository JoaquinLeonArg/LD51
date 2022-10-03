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
var play_hint_t: float = 0.0

var type_names: Dictionary = {
	cd.CardType.ACTION: "Action",
	cd.CardType.BUILDING: "Building",
	cd.CardType.ENVIRONMENT: "Environment"
}

var type_icons: Dictionary = {
	cd.CardType.ACTION: preload("res://RawResources/Graphics/icon-ACTION.png"),
	cd.CardType.BUILDING: preload("res://RawResources/Graphics/icon-BUILDING.png"),
	cd.CardType.ENVIRONMENT: preload("res://RawResources/Graphics/icon-TREE.png")
}

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
	self.process_input()
	self.process_play_hint(delta)

func set_data(_data):
	self.data = _data
	$Front/CardArea/CardName.bbcode_text = "[center]%s[/center]" % self.data.card_name
	$Front/CardArea/CardCost.bbcode_text = "[center]%s[/center]" % self.data.ap_cost
	$Front/CardArea/CardDescription.bbcode_text = "[center]%s[/center]" % self.data.description
	$Front/CardArea/CardTypes.bbcode_text = "[center]%s[/center]" % self.type_names[self.data.type]
	$Front/CardArea/TypeSprite.texture = self.type_icons[self.data.type]
	if self.data.type == cd.CardType.BUILDING:
		$Front/WoodCost.visible = true
		$Front/WoodCost/WoodCostText.bbcode_text = "[center]%s[/center]" % self.data.wood_cost
	else:
		$Front/WoodCost.visible = false

	var _x
	_x = self.data.connect("entered_field", self, "entered_field")
	_x = self.data.connect("entered_discard", self, "entered_discard")
	_x = self.data.connect("entered_deck", self, "entered_deck")

	_x = self.data.connect("duration_over", self, "duration_over")
	_x = self.data.connect("cooldown_over", self, "cooldown_over")
	_x = self.data.connect("get_upgraded", self, "get_upgraded")

func process_input():
	if not self.enabled:
		return
	if State.state.paused:
		if self.dragging:
			self.dragging = false
			self.update_position()
		if State.state.current_card == self:
			State.state.current_card = null
		
		return
	var tween = create_tween()
	if self.hovering and self.draggable:
		if Input.is_action_just_pressed("left_click"):
			if State.state.current_card:
				if State.state.current_card == self:
					self.update_position()
				var card = State.state.current_card
				card.dragging = false
				State.state.current_card = null
			else:
				if self.data.can_be_played():
					#print("Drag")
					self.dragging = true
					State.state.current_card = self
					tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.2)
					self.drag_offset = get_global_mouse_position() - self.global_position
	if self.dragging and self.draggable:
		#tween.tween_property(self, "global_position", get_global_mouse_position() - self.drag_offset, 0.01)
		self.global_position = get_global_mouse_position() - self.drag_offset
		self.rotation = (self.global_position.x - get_global_mouse_position().x + self.drag_offset.x)*0.002

func process_play_hint(delta):
	self.play_hint_t += delta*10
	$Front/PlayHint.rect_scale = Vector2(1.0 + 0.01*cos(self.play_hint_t), 1.0 + 0.01*cos(self.play_hint_t))
	if State.state.current_card == self:
		$Front/PlayHint.visible = true
		$Front/PlayHint.color = "#8da24e"
		return
	if self.data.can_be_played() and self.data.zone_data.get_zone() == cd.CardZone.HAND:
		$Front/PlayHint.visible = true
		$Front/PlayHint.color = "#ffffff"
		return
	if not self.data.can_be_played() and self.data.zone_data.get_zone() == cd.CardZone.HAND:
		$Front/PlayHint.visible = true
		$Front/PlayHint.color = "#933942"
		return
	if not self.data.can_be_played() and self.data.zone_data.get_zone() == cd.CardZone.HAND:
		$Front/PlayHint.visible = true
		$Front/PlayHint.color = "#933942"
		return
	$Front/PlayHint.visible = false

func on_mouse_entered():
	Sound.sound.play_effect("hover")
	if State.state.current_card:
		return
	var tween = create_tween()
	self.hovering = true
	self.z_index = 1
	tween.tween_property(self, "scale", self.hover_scale, 0.1)
	tween.tween_property(self, "global_position", self.hover_position, 0.1)
	tween.tween_property(self, "rotation", self.hover_rotation, 0.1)

func on_mouse_exited():
	if State.state.current_card:
		return
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
	tween.tween_property(self, "scale", Vector2(self.rest_scale.x, self.rest_scale.y), duration)
	self.is_showing = not self.is_showing

func get_upgraded():
	pass
	# Implement UI for upgrades
