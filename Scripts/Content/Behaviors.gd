extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")

class ChangeResourceBehavior extends cd.CardBehavior:
	const cd = preload("res://Scripts/Classes/CardData.gd")

	var resource_type: int
	var amount: int

	func _init(_resource_type: int, _amount: int).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.amount = _amount
	func on_play(_target=null):
		.on_play()
		if(self.amount > 0):
			State.state.resources.data.gain_resource(self.resource_type, self.amount)
		else:
			State.state.resources.data.spend_resource(self.resource_type, self.amount)

class StaticHandSizeBehavior extends cd.CardBehavior:
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
	# TODO

class DynamicBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	# TODO

class ClickBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	# TODO

class ChangeModifierBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	# TODO