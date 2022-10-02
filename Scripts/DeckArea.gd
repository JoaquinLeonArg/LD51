extends Node2D



# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const dd = preload("res://Scripts/Classes/DeckData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")


# Instance properties
var data: dd.DeckData
var count: int = 0
var draw_timer: float = 0.0

# Methods
func _ready():
	var _x
	self.data = dd.DeckData.new()
	_x = self.data.connect("updated_cards", self, "update_text")
	State.state.deck = self

func add_card(card):
	self.data.cards.append(card)
	var old_pos = card.global_position
	if card.get_parent():
		card.get_parent().remove_child(card)
	self.add_child(card)
	card.global_position = old_pos
	
	card.rest_position = self.global_position
	card.rest_scale = Vector2(1.0, 1.0)
	card.rest_rotation = 0
	card.hover_position = self.global_position
	card.hover_scale = Vector2(1.0, 1.0)
	card.hover_rotation = 0
	card.draggable = false

	card.data.zone_data = cd.DeckCardZoneData.new()

	card.update_position()

func _input(event):
	if self.is_mouse_hovering() and event.is_action_pressed("left_click") and not State.state.current_card and self.draw_timer == 0.0:
		self.start_draw()

func start_draw():
	self.draw_timer = 3.0
	$Progress.visible = true
	
func _process(delta):
	if self.draw_timer > 0.0:
		self.draw_timer -= delta
		if self.draw_timer <= 0.0:
			self.data.draw_action()
			$Progress.visible = false
	self.draw_timer = max(self.draw_timer, 0.0)
	$Progress.value = 1.0 - draw_timer / State.state.resources.data.extra_resources[rd.ExtraResourceType.DRAW_TIME]

func update_text():
	self.count = len(self.data.cards)
	$Text.bbcode_text = " DECK (%s)" % self.count

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.global_position.x + 64) < 128,
		(get_global_mouse_position().y - self.global_position.y + 152) < 196,
		(get_global_mouse_position().x - self.global_position.x + 64) > 0,
		(get_global_mouse_position().y - self.global_position.y + 152) > 0
	].count(true) == 4
	
