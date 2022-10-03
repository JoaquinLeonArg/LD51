extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")

class ChangeResourceBehavior extends cd.CardBehavior:
	const cd = preload("res://Scripts/Classes/CardData.gd")

	var resource_type: int
	var change: int
	var upgrade_factor: int

	func _init(_resource_type: int, _change: int, _upgrade_factor: int=1).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
		self.upgrade_factor = _upgrade_factor
	func on_play(_target=null):
		.on_play()
		if(self.change > 0):
			State.state.resources.data.gain_resource(self.resource_type, self.change + self.owner.upgrade * self.upgrade_factor)
		else:
			State.state.resources.data.spend_resource(self.resource_type, self.change)

class ChangeExtraResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var resource_type
	var change

	func _init(_resource_type, _change).(cd.CardBehaviorPriority.NORMAL):
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
			behavior.on_activated()
		for behavior in self.behaviors:
			behavior.on_play()
	func can_be_activated():
		for behavior in self.behaviors:
			if not behavior.can_be_activated():
				return false
		return true

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
	var perm: bool

	func _init(_resource_type: int, _change: float, _perm: bool=false ).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
		self.perm = _perm
	func on_play(_target=null):
		.on_play()
		State.state.resources.data.change_maint_resource(self.resource_type, self.change)
	func on_destroy():
		.on_destroy()
		if self.perm:
			return
		State.state.resources.data.change_maint_resource(self.resource_type, -self.change)

class YearChangeResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")
	
	var resource_type: int
	var change: float
	var modifier: int

	func _init(_resource_type: int, _change: float, _modifier: int=-1).(cd.CardBehaviorPriority.NORMAL):
		self.resource_type = _resource_type
		self.change = _change
		self.modifier = _modifier
	func on_year_change(_target=null):
		.on_year_change()

		if not self.owner:
			print("Error: 1 can't find position on YearChangeResourceBehavior")
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on YearChangeResourceBehavior")
		var this_slot = State.state.field.get_slot_by_position(this_position)
		if not this_slot:
			print("Error: 3 can't find position on YearChangeResourceBehavior")
			return 

		var mod = 1.0
		if self.modifier != -1 and this_slot:
			mod = this_slot.data.modifiers[psd.SlotModifier.FARM_PROD]
		State.state.resources.data.gain_resource(self.resource_type, self.change*mod)

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
		for slot in State.state.field.slots:
			if slot.card:
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
		State.state.deck.data.draw(self.card_count)

class DeforestationBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	func can_be_played():
		for slot in State.state.field.slots:
			if slot.card:
				if slot.card.data.card_name == "Woodlands":
					return true
		return false
	func on_play(_target=null):
		.on_play()
		for slot in State.state.field.slots:
			if slot.card:
				if slot.card.data.card_name == self.card_name:
					slot.destroy_card()
					State.state.resources.data.gain_resource(rd.ResourceType.WOOD, 10)

class ReforestationBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const cd = preload("res://Scripts/Classes/CardData.gd")
	const card_component = preload("res://Components/Card.tscn")

	var card_data
	
	func _init(_card_data).(cd.CardBehaviorPriority.NORMAL):
		self.card_data = _card_data

	func can_be_played():
		return len(State.state.field.get_free_slots(true)) > 0
	func on_play(_target=null):
		.on_play()
		var slots = State.state.field.get_free_slots(true)
		slots.shuffle()
		for slot in [slots.pop_back(), slots.pop_back()]:
			if not slot:
				return
			var card_props = self.card_data.new()
			var card = card_component.instance()
			card.set_data(cd.CardData.new(card_props))
			card.data.ui_owner = card
			card.data.zone_data = cd.FieldCardZoneData.new(slot)
			card.global_position = slot.global_position
			slot.add_card(card)

class HasResourceBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var resource_type: int
	var amount: int

	func _init(_resource_type: int, _amount: int):
		self.resource_type = _resource_type
		self.amount = _amount

	func can_be_played():
		return State.state.resources.data.resources[self.resource_type] >= self.amount

class ChangeAdjacentSlotsModifier extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")
	
	var modifier_type: int
	var change: float

	func _init(_modifier_type: int, _change: float).(cd.CardBehaviorPriority.NORMAL):
		self.modifier_type = _modifier_type
		self.change = _change
	func on_play(_target=null):
		.on_play()
		if not self.owner:
			print("Error: 1 can't find position on ChangeAdjacentSlotsModifier")
			return
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on ChangeAdjacentSlotsModifier")
			return
		var adjacents = State.state.field.get_adjacent_slots(this_position)
		for adj in adjacents:
			if adj:
				adj.modifiers[self.modifier_type] += self.change

	func on_destroy(_target=null):
		.on_destroy()
		if not self.owner:
			print("Error: 1 can't find position on ChangeAdjacentSlotsModifier")
			return
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on ChangeAdjacentSlotsModifier")
			return
		var adjacents = State.state.field.get_adjacent_slots(this_position)
		for adj in adjacents:
			if adj:
				adj.modifiers[self.modifier_type] -= self.change

class FarmBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

	func on_season_change(_target=null):
		.on_season_change()
		if not self.owner:
			print("Error: 1 can't find position on FarmBehavior")
			return
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on FarmBehavior")
			return
		var this_slot = State.state.field.get_slot_by_position(this_position)
		if not this_slot:
			print("Error: 3 can't find position on FarmBehavior")
			return 
		
		State.state.resources.data.gain_resource(rd.ResourceType.FOOD, (5 + self.owner.upgrade)*this_slot.data.modifiers[psd.SlotModifier.FARM_PROD])

class LumberCampBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

	func on_season_change(_target=null):
		.on_season_change()
		if not self.owner:
			print("Error: 1 can't find position on LumberCampBehavior")
			return
		var this_position = State.state.field.get_position_with_card(self.owner)
		if not this_position:
			print("Error: 2 can't find position on LumberCampBehavior")
			return
		var this_slot = State.state.field.get_slot_by_position(this_position)
		if not this_slot:
			print("Error: 3 can't find position on LumberCampBehavior")
			return 
		State.state.resources.data.gain_resource(rd.ResourceType.WOOD, (3 + self.owner.upgrade*2)*this_slot.data.modifiers[psd.SlotModifier.WOOD_PROD])

class UpgradeBehavior extends cd.CardBehavior:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")

	var cost: int
	var required: bool

	func _init(_cost: int, _required: bool=true).(cd.CardBehaviorPriority.LOW):
		self.cost = _cost
		self.required = _required

	func on_activated():
		if self.owner.upgrade < self.owner.max_upgrade and State.state.resources.data.resources[rd.ResourceType.GOLD] >= self.cost:
			State.state.resources.data.spend_resource(rd.ResourceType.GOLD, self.cost)
			self.owner.get_upgraded()
	func can_be_activated():
		if not self.required:
			return State.state.resources.data.resources[rd.ResourceType.GOLD] >= self.cost
		return self.owner.upgrade < self.owner.max_upgrade and State.state.resources.data.resources[rd.ResourceType.GOLD] >= self.cost

class OnCardUseSoundBehavior extends cd.CardBehavior:

	var sound: String
	func _init(_sound: String):
		self.sound = _sound

	func on_play(_target=null):
		Sound.sound.play_effect(sound)

class OnCardInteractionSoundBehavior extends cd.CardBehavior:

	var sound: String
	func _init(_sound: String):
		self.sound = _sound

	func on_activated():
		Sound.sound.play_effect(sound)
		
