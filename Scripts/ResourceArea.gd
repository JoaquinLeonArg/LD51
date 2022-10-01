extends Node2D

# Signals

# Imports
const rd = preload("res://Scripts/Classes/ResourceData.gd")

# Instance properties
var data: rd.ResourceData
onready var resources: Dictionary = {
	rd.ResourceType.PEOPLE: {
		"value": 0,
		"change": 0
	},
	rd.ResourceType.FOOD: {
		"value": 0,
		"change": 0
	},
	rd.ResourceType.WOOD: {
		"value": 0,
		"change": 0
	},
	rd.ResourceType.GOLD: {
		"value": 0,
		"change": 0
	},
}

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
	_x = self.data.connect("resource_value_changed", self, "update_resource_value")
	_x = self.data.connect("resource_change_changed", self, "update_resource_change")

func update_resource_value(resource_type, _old, value):
	self.resources[resource_type]["value"] = value
	self.update_ui()

func update_resource_change(resource_type, _old, change):
	self.resources[resource_type]["change"] = change
	self.update_ui()

func update_ui():
	print('testtest')
	for resource_type in [rd.ResourceType.PEOPLE, rd.ResourceType.FOOD, rd.ResourceType.WOOD, rd.ResourceType.GOLD]:
		var change_color: String
		var change_sign: String
		var change = self.resources[resource_type]["change"]
		var new = self.resources[resource_type]["value"]

		if change > 0:
			change_color = "#123456"
			change_sign = "+"
		if change == 0:
			change_color = "#654321"
			change_sign = ""
		if change < 0:
			change_color = "#126534"
			change_sign = "-"
		var tween = create_tween()
		self.resource_nodes[resource_type].bbcode_text = "%s ([color=%s]%s%s[/color])" % [new, change_color, change_sign, change]
		tween.tween_property(self.resource_nodes[resource_type], "rect_scale", Vector2(0.12, 0.12), 0.1)
		tween.tween_property(self.resource_nodes[resource_type], "rect_scale", Vector2(0.1, 0.1), 0.1)
