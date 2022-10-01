extends Node2D

# Signals

# Imports
const rd = preload("res://Scripts/Classes/ResourceData.gd")

# Instance properties
var data: rd.ResourceData

onready var resource_nodes: Dictionary = {
	rd.ResourceType.PEOPLE: $PeopleCount,
	rd.ResourceType.FOOD: $FoodCount,
	rd.ResourceType.WOOD: $WoodCount,
	rd.ResourceType.GOLD: $GoldCount,
}

# Methods
func _ready():
	self.data = rd.ResourceData.new()
	State.state.resources = self
	var _x
	_x = self.data.connect("resource_changed", self, "update_resource")

func update_resource(resource_type: int, _old: int, new: int, change: int):
	var change_color: String
	var change_sign: String
	if change > 0:
		change_color = "#123456"
		change_sign = "+"
	if change == 0:
		change_color = "#654321"
		change_sign = ""
	if change < 0:
		change_color = "#126534"
		change_sign = "-"
	self.resource_nodes[resource_type].bbcode_text = "%s ([color=%s]%s%s[/color])" % [new, change_color, change_sign, change]
