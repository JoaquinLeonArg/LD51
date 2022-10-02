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

# Methods
func _ready():
	State.state.field = self
	for i in range(FIELD_WIDTH):
		for j in range(FIELD_HEIGHT):
			var slot = slot_component.instance()
			slot.position = Vector2((128 + 8) * i + 8 - 128 * float(FIELD_WIDTH)/2 + 64, (196 + 8) * j + 8 + 152)
			slot.data = psd.PlaySlotData.new(psd.SlotType.SLOT_A, i*FIELD_WIDTH + j)
			self.add_child(slot)
