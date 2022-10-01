extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")

class ChangeResourceBehavior extends cd.CardBehavior:
	const cd = preload("res://Scripts/Classes/CardData.gd")

	var resource_type: int
	var change: int

	func _init(_resource_type: int, _change: int).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		if(self.change > 0):
			State.state.resources.data.gain_resource(self.resource_type, self.change)
		else:
			State.state.resources.data.spend_resource(self.resource_type, self.change)

class ChangeHandSizeBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var change: int

	func _init(_change: int).(cd.CardBehaviorPriority.NORMAL):
		self.change = _change
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_extra_resource(rd.ExtraResourceType.HAND_SIZE, self.change)
	func on_destroy():
		.on_destroy()
		State.state.resources.data.change_extra_resource(rd.ExtraResourceType.HAND_SIZE, -self.change)

class ChangeMaxResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var resource_type: int
	var change: int

	func _init(_resource_type, _change: int).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_max_resource(self.resource_type, self.change)
	func on_destroy():
		.on_destroy()
		State.state.resources.data.change_max_resource(self.resource_type, -self.change)

class DynamicBehavior extends cd.CardBehavior:
	const cd = preload("res://Scripts/Classes/CardData.gd")
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var behaviors: Array

	func _init(_behaviors: Array).(cd.CardBehaviorPriority.NORMAL):
		self.behaviors = _behaviors
	func set_owner(_owner: cd.CardData):
		.set_owner(_owner)
		for behavior in self.behaviors:
			behavior.set_owner(self.owner)
	func on_cooldown():
		.on_cooldown()
		for behavior in self.behaviors:
			behavior.on_play()


class ClickBehavior extends cd.CardBehavior:
	const cd = preload("res://Scripts/Classes/CardData.gd")
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var behaviors: Array

	func _init(_behaviors: Array).(cd.CardBehaviorPriority.NORMAL):
		self.behaviors = _behaviors
	func set_owner(_owner: cd.CardData):
		.set_owner(_owner)
		for behavior in self.behaviors:
			behavior.set_owner(self.owner)
	func on_activated():
		.on_activated()
		for behavior in self.behaviors:
			behavior.on_play()

class ChangeModifierBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	
	var resource_type: int
	var change: float

	func _init(_resource_type: int, _change: float).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_mod_resource(self.resource_type, self.change)
	func on_destroy():
		.on_destroy()
		State.state.resources.data.change_mod_resource(self.resource_type, -self.change)