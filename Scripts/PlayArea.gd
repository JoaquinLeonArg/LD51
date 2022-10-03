extends Node2D

# Imports
const slot_component = preload("res://Components/PlayAreaSlot.tscn")
const card_component = preload("res://Components/Card.tscn")
const psd = preload("res://Scripts/Classes/PlaySlotData.gd")
const cd = preload("res://Scripts/Classes/CardData.gd")
const card_content = preload("res://Scripts/Content/Cards.gd")

# Constants
const FIELD_WIDTH: int = 7
const FIELD_HEIGHT: int = 3

# Properties
onready var actions_area: ColorRect = $ActionArea
var slots: Array = []

var slot_positions: Dictionary = {}

# Methods
func _ready():
	State.state.field = self

	for i in range(FIELD_WIDTH):
		for j in range(FIELD_HEIGHT):
			
			var slot = slot_component.instance()
			
			self.slot_positions[Vector2(i, j)] = slot
			slot.position = Vector2((128 + 8) * i + 8 - 128 * float(FIELD_WIDTH)/2 + 64, (196 + 8) * j + 8 + 152)
			slot.data = psd.PlaySlotData.new(psd.SlotType.SLOT_A, i*FIELD_WIDTH + j)
			
			self.add_child(slot)
			self.slots.append(slot)

func initialize():
	var bag = []
	for i in range(FIELD_WIDTH):
		for j in range(FIELD_HEIGHT):
			var slot = self.get_slot_by_position(Vector2(i, j))
			if i == 0 or i == FIELD_WIDTH - 1:
				if slot:
					slot.data.lock()
			else:
				bag.append(slot)
	bag.shuffle()
	var forest_slots = [bag.pop_back(), bag.pop_back(), bag.pop_back()]
	var lake_slot = bag.pop_back()
	for slot in forest_slots:
		var card_props = card_content.WoodlandCard.new()
		var card = card_component.instance()
		card.set_data(cd.CardData.new(card_props))
		card.data.ui_owner = card
		card.global_position = slot.global_position
		slot.add_card(card)
	var card_props = card_content.LakeCard.new()
	var card = card_component.instance()
	card.set_data(cd.CardData.new(card_props))
	card.data.ui_owner = card
	card.data.zone_data = cd.FieldCardZoneData.new(lake_slot)
	card.global_position = lake_slot.global_position
	lake_slot.add_card(card)


func get_slot_by_position(_pos: Vector2):
	return self.slot_positions.get(_pos)

func get_position_with_card(_card):
	for pos in self.slot_positions.keys():
		var slot = self.slot_positions[pos]
		if slot.card and slot.card.data == _card:
			return pos

func get_adjacent_slots(_pos: Vector2):
	var offsets = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
	var adj = []
	for offset in offsets:
		var slot = self.slot_positions.get(_pos + offset)
		if slot:
			adj.append(slot)
	return adj

func season_end():
	for slot in self.slots:
		if slot.card:
			slot.card.data.on_season()

func year_end():
	for slot in self.slots:
		if slot.card:
			slot.card.data.on_year()
