extends Node2D

# Constants


# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")
const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

# Instance properties
var card = null
var slot_index = 0
var data: psd.PlaySlotData = null

func _ready():
	var _x
	_x = self.data.connect("unlock", self, "unlock")
	_x = self.data.connect("lock", self, "lock")

func process_input():
	
	if Input.is_action_just_pressed("left_click") and self.data.locked and self.is_mouse_hovering() and State.state.current_card == null:
		self.data.unlock()
		Sound.sound.play_effect("cash_register")
	if not self.is_mouse_hovering() or self.data.locked:
		return
	if Input.is_action_just_released("left_click"):
		if State.state.current_card and State.state.current_card.data.type == cd.CardType.BUILDING and not self.card:
			if State.state.resources.data.resources[rd.ResourceType.WOOD] >= State.state.current_card.data.wood_cost:
				State.state.resources.data.spend_resource(rd.ResourceType.WOOD, State.state.current_card.data.wood_cost)
				self.add_card(State.state.current_card)
				State.state.current_card = null
				State.state.hand.remove_card(self.card)
				self.card.update_position()
				self.card.data.entered_field(self)
				Sound.sound.play_effect("building")
				return
			else:
				var curr_card = State.state.current_card
				curr_card.dragging = false
				State.state.current_card = null
		if State.state.current_card and self.card:
			var curr_card = State.state.current_card
			curr_card.dragging = false
			State.state.current_card = null


func _process(_delta):
	self.process_input()
	var tween = create_tween()
	var current_card = State.state.current_card
	if current_card:
		if current_card.data.type == cd.CardType.BUILDING:
			tween.tween_property($Sprite, "modulate:a", 0.5, 0.2)
			if self.is_mouse_hovering():
				tween.tween_property($Area, "modulate:a", 0.25, 0.2)
	if not self.is_mouse_hovering():
		$Area.modulate.a = 0
	if not current_card or current_card.data.type != cd.CardType.BUILDING:
		$Sprite.modulate.a = 0.25

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.global_position.x + 64) < 128,
		(get_global_mouse_position().y - self.global_position.y + 152) < 196,
		(get_global_mouse_position().x - self.global_position.x + 64) > 0,
		(get_global_mouse_position().y - self.global_position.y + 152) > 0
	].count(true) == 4

func lock():
	$Lock.visible = true

func unlock():
	$Lock.visible = false

func add_card(_card):
	self.card = _card
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
	self.card.hover_scale = Vector2(1.5, 1.5)
	self.card.draggable = false

	self.card.dragging = false

	self.card.data.zone_data = cd.FieldCardZoneData.new(self.slot_index)

func destroy_card():
	if not self.card:
		return
	self.card.queue_free()
	self.card = null
	self.data.card = null
