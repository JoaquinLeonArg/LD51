extends Node2D

# Constants
const RARE_UNLOCK_YEAR: int = 3
const LEGENDARY_UNLOCK_YEAR: int = 7

# Imports
const content_cards = preload("res://Scripts/Content/Cards.gd")
const card_component = preload("res://Components/Card.tscn")
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")

# Properties
var data: cd.CardData
var card: Node2D
var bought: bool = false
var enabled: bool = true
var button_hovering: bool = false

# Methods
func _ready():

	var _x
	_x = $BuyButton.connect("mouse_entered", self, "on_mouse_entered_button")
	_x = $BuyButton.connect("mouse_exited", self, "on_mouse_exited_button")

func initialize():
	self.refresh()

func _process(_delta):
	if self.bought:
		$Cost.bbcode_text = "[color=%s] %s[/color]" % ["#111111", self.data.draft_cost]
		$BuyButton.color = "#111111"
		return
	if State.state.resources.data.resources[rd.ResourceType.GOLD] < self.data.draft_cost:
		self.enabled = false
		$Cost.bbcode_text = "[color=%s] %s[/color]" % ["#882222", self.data.draft_cost]
		$BuyButton.color = "#882222"
		return
	if State.state.resources.data.resources[rd.ResourceType.GOLD] >= self.data.draft_cost:
		self.enabled = true
		$Cost.bbcode_text = "[color=%s] %s[/color]" % ["#228822", self.data.draft_cost]
		$BuyButton.color = "#228822"
		if self.button_hovering:
			$BuyButton.color = "#55cc55"
		return

func _input(event):
	if event.is_action_pressed("left_click") and self.button_hovering:
		if self.enabled and not self.bought:
			Sound.sound.play_effect("cash_register")
			self.bought = true
			State.state.discard.add_card(self.card)
			self.card = null
			State.state.resources.data.spend_resource(rd.ResourceType.GOLD, self.data.draft_cost)

func choose_card():
	var available_rarities: Array = [cd.CardRarity.COMMON]
	var available_cards: Array = []
	if State.state.seasons.data.year >= RARE_UNLOCK_YEAR:
		available_rarities.append(cd.CardRarity.RARE)
	if State.state.seasons.data.year >= LEGENDARY_UNLOCK_YEAR:
		available_rarities.append(cd.CardRarity.LEGENDARY)
	for this_card in content_cards.new().all_cards:
		if this_card.new().rarity in available_rarities:
			available_cards.append(this_card)
	available_cards.shuffle()
	return available_cards.pop_back()

func refresh():
	self.bought = false
	if self.card:
		self.card.queue_free()
	self.data = cd.CardData.new(self.choose_card().new())
	self.card = card_component.instance()
	self.card.set_data(self.data)
	var offset: Vector2 = Vector2.ZERO
	if self.global_position.y < 0:
		offset = Vector2(0, 1000)

	card.rest_position = self.global_position + offset
	card.rest_scale = Vector2(1.5, 1.5)
	card.rest_rotation = 0
	card.hover_position = self.global_position + offset
	card.hover_scale = Vector2(1.8, 1.8)
	card.hover_rotation = 0
	card.draggable = false

	card.data.zone_data = cd.DeckCardZoneData.new()

	card.scale = Vector2(1.5, 1.5)
	card.update_position()

	add_child(self.card)

func on_mouse_entered_button():
	Sound.sound.play_effect("hover")
	self.button_hovering = true

func on_mouse_exited_button():
	self.button_hovering = false
