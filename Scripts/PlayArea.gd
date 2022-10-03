extends Node2D

# Imports
const slot_component = preload("res://Components/PlayAreaSlot.tscn")
const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

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
	#print(self.slot_positions)

func initialize():
	for i in range(FIELD_WIDTH):
		for j in range(FIELD_HEIGHT):
			if i == 0 or i == FIELD_WIDTH - 1:
				var slot = self.get_slot_by_position(Vector2(i, j))
				if slot:
					slot.data.lock()

func get_slot_by_position(_pos: Vector2):
	return self.slot_positions.get(_pos)

func get_adjacent_slots(_pos: Vector2):
	var offsets = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
	var adj = []
	for offset in offsets:
		var slot = self.slot_positions.get(_pos + offset)
		if slot:
			adj.append(slot)
	return adj