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
	_x = self.data.connect("resources_changed", self, "update_resources")
	self.update_resources()
	self.update_ui()

func update_resources():
	print("resources updating")
	#var tween = create_tween()
	#tween.tween_property(self.resource_nodes[resource_type], "rect_scale", Vector2(0.12, 0.12), 0.1)
	#tween.tween_property(self.resource_nodes[resource_type], "rect_scale", Vector2(0.1, 0.1), 0.1)
	for resource in self.resources.keys():
		self.resources[resource]["value"] = self.data.resources[resource]
	self.update_ui()

func update_resource_change(resource_type, _old, change):
	self.resources[resource_type]["change"] = change
	self.update_ui()

func update_ui():
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
		self.resource_nodes[resource_type].bbcode_text = "%s ([color=%s]%s%s[/color])" % [new, change_color, change_sign, change]
		
