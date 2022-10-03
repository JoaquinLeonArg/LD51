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

class ChangeExtraResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var resource_type: int
	var change: float

	func _init(_resource_type: int, _change: float).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_extra_resource(self.resource_type, self.change)
	func on_destroy():
		.on_destroy()
		State.state.resources.data.change_extra_resource(self.resource_type, -self.change)

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


class ChangeMaintenanceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	
	var resource_type: int
	var change: float

	func _init(_resource_type: int, _change: float).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_maint_resource(self.resource_type, self.change)
	func on_destroy():
		.on_destroy()
		State.state.resources.data.change_maint_resource(self.resource_type, -self.change)

class YearChangeResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	
	var resource_type: int
	var change: float

	func _init(_resource_type: int, _change: float).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
	func on_year_change(_target=null):
		.on_year_change()
		State.state.resources.data.gain_resource(self.resource_type, self.change)

class SeasonChangeResourceByAdjacencyBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	
	var resource_type: int
	var factor: float

	func _init(_resource_type: int, _factor: float).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.factor = _factor
	func on_season_change(_target=null):
		.on_season_change()
		if not self.owner:
			print("Error: 1 can't find position on SeasonChangeResourceByAdjacencyBehavior")
			return
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on SeasonChangeResourceByAdjacencyBehavior")
			return
		var adjacents = State.state.field.get_adjacent_slots(this_position)
		var count = 0
		for adj in adjacents:
			if adj:
				count += 1
		print("Gained %s of resource %s on season change" % [self.factor * count, self.resource_type])
		State.state.resources.data.gain_resource(self.resource_type, self.factor * count)

class DestroyTypeBuildingBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	var card_name: String
	var may: bool

	func _init(_card_name: String, _may: bool=false).(cd.CardBehaviorPriority.HIGH):
		self.card_name = _card_name
		self.may = _may
	func can_be_played():
		print(self.card_name)
		for slot in State.state.field.slots:
			if slot.card:
				print(slot.card.data.card_name)
				if slot.card.data.card_name == self.card_name:
					return true
					
		return false
	func on_play(_target=null):
		.on_play()
		var valid_slots = []
		for slot in State.state.field.slots:
			if slot.card:
				if slot.card.data.card_name == self.card_name:
					valid_slots.append(slot)
		valid_slots.shuffle()
		var slot = valid_slots.pop_back()
		slot.destroy_card()

class DrawCardsBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	var card_count: int

	func _init(_card_count: int).(cd.CardBehaviorPriority.NORMAL):
		self.card_count = _card_count
	func on_play(_target=null):
		.on_play()
		State.state.deck.draw(self.card_count)