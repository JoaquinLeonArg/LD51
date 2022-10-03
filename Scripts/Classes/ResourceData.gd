enum ResourceType { PEOPLE, FOOD, WOOD, GOLD }
enum ExtraResourceType { HAND_SIZE, DRAW_SIZE, DRAW_TIME, AP, AP_MAX }

class ResourceData:

	const fx_component = preload("res://Components/ResourceEffect.tscn")

	var ui_owner: Node2D
	var resources: Dictionary = {
		ResourceType.PEOPLE: 30,
		ResourceType.FOOD: 15,
		ResourceType.WOOD: 20,
		ResourceType.GOLD: 25,
	}
	var resource_max: Dictionary = {
		ResourceType.PEOPLE: 999,
		ResourceType.FOOD: 50,
		ResourceType.WOOD: 100,
		ResourceType.GOLD: 200,
	}
	var resource_mod: Dictionary = {
		ResourceType.PEOPLE: 1.0,
		ResourceType.FOOD: 1.0,
		ResourceType.WOOD: 1.0,
		ResourceType.GOLD: 1.0,
	}
	var resource_maintenance: Dictionary = {
		ResourceType.PEOPLE: 0,
		ResourceType.FOOD: State.state.difficulty,
		ResourceType.WOOD: 0,
		ResourceType.GOLD: 0,
	}
	var resource_production: Dictionary = {
		ResourceType.PEOPLE: 0,
		ResourceType.FOOD: 0,
		ResourceType.WOOD: 0,
		ResourceType.GOLD: 0,
	}
	var extra_resources: Dictionary = {
		ExtraResourceType.HAND_SIZE: 3,
		ExtraResourceType.DRAW_SIZE: 2,
		ExtraResourceType.AP: 3,
		ExtraResourceType.AP_MAX: 3,
		ExtraResourceType.DRAW_TIME: 2.0
	}

	var timer: float = 0.0

	signal resources_changed
	signal game_over

	func _init():
		emit_signal("resources_changed")
	func update(delta):
		if State.state.paused:
			return
		self.timer += delta
		if self.timer >= 2:
			self.timer -= 2
			self.resource_tick()
		if self.resources[ResourceType.PEOPLE] <= 0:
			emit_signal("game_over")
			State.state.paused = true
	func gain_resource(_resource_type: int, _amount: int, _owner=null):
		# if _owner and _owner.ui_owner:
		# 	var fx = fx_component.instance()
		# 	fx.global_position = _owner.ui_owner.global_position
		# 	fx.set_data(_resource_type, _amount)
		# 	_owner.ui_owner.add_child(fx)
		self.resources[_resource_type] += _amount * self.resource_mod[_resource_type]
		self.resources[_resource_type] = min(self.resources[_resource_type], self.resource_max[_resource_type])
		emit_signal("resources_changed")
		print("Resource %s changed by %s to %s" % [_resource_type, _amount, self.resources[_resource_type]])
	func spend_resource(_resource_type: int, _amount: int):
		self.resources[_resource_type] -= _amount
		if resources[ResourceType.FOOD] < 0 :
			resources[ResourceType.PEOPLE] += 2*resources[ResourceType.FOOD]
			resources[ResourceType.PEOPLE] = max(resources[ResourceType.PEOPLE], 0)
		self.resources[_resource_type] = max(self.resources[_resource_type], 0)
		emit_signal("resources_changed")
	func change_extra_resource(_resource_type: int, _change: float):
		self.extra_resources[_resource_type] += _change
		emit_signal("resources_changed")
	func change_mod_resource(_resource_type: int, _change: float):
		self.resource_mod[_resource_type] += _change
		emit_signal("resources_changed")
	func change_max_resource(_resource_type: int, _change: int):
		self.max_resources[_resource_type] += _change
		emit_signal("resources_changed")
	func change_maint_resource(_resource_type: int, _change: int):
		self.resource_maintenance[_resource_type] += _change
		emit_signal("resources_changed")
	func replenish_ap():
		self.extra_resources[ExtraResourceType.AP] = min(self.extra_resources[ExtraResourceType.AP] + self.extra_resources[ExtraResourceType.AP_MAX], self.extra_resources[ExtraResourceType.AP_MAX])
		emit_signal("resources_changed")
	func resource_tick():
		for resource in self.resource_maintenance.keys():
			self.resources[resource] += self.resource_production[resource] - self.resource_maintenance[resource]
			if resources[ResourceType.FOOD] < 0:
				resources[ResourceType.PEOPLE] += (State.state.difficulty + 1)*resources[ResourceType.FOOD]
				resources[ResourceType.PEOPLE] = max(resources[ResourceType.PEOPLE], 0)
			self.resources[resource] = max(self.resources[resource], 0)
			self.resources[resource] = min(self.resources[resource], self.resource_max[resource])
		emit_signal("resources_changed")
		
