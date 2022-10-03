extends Node2D

# Signals

# Imports
const rd = preload("res://Scripts/Classes/ResourceData.gd")
const gameover_component = preload("res://Components/GameOver.tscn")

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
	_x = self.data.connect("game_over", self, "game_over")
	self.update_resources()
	self.update_ui()

func _process(delta):
	self.data.update(delta)

func update_resources():
	#print("resources updating")
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
	for resource_type in self.resource_nodes.keys():
		var value_color: String
		var change_color: String
		var change_sign: String = ""
		var change = self.data.resource_production[resource_type] - self.data.resource_maintenance[resource_type]
		var value = self.resources[resource_type]["value"]
		var max_capacity = self.data.resource_max[resource_type]

		var max_capacity_text = ""
		if resource_type != rd.ResourceType.PEOPLE:
			max_capacity_text = " / %s" % max_capacity

		if value > 10:
			value_color = "#8da24e"
		else:
			value_color = "#933942"

		if change < 0:
			change_color = "#933942"
		if change > 0:
			change_color = "#8da24e"
			change_sign = "+"
		if change == 0:
			change_color = "#333333"

		
		self.resource_nodes[resource_type].bbcode_text = "[color=%s]%s[/color]%s ([color=%s]%s%s[/color])" % [value_color, value, max_capacity_text, change_color, change_sign, change]
	$APCount.bbcode_text = "%s / %s" % [self.data.extra_resources[rd.ExtraResourceType.AP], self.data.extra_resources[rd.ExtraResourceType.AP_MAX]]
	$DrawCount.bbcode_text = "%s / %s (+%s)" % [len(State.state.hand.data.cards), self.data.extra_resources[rd.ExtraResourceType.HAND_SIZE], self.data.extra_resources[rd.ExtraResourceType.DRAW_SIZE]]


func game_over():
	self.get_tree().current_scene.add_child(self.gameover_component.instance())
