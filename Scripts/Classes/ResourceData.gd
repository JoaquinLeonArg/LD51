enum ResourceType { PEOPLE, FOOD, WOOD, GOLD }
enum ExtraResourceType { HAND_SIZE, DRAW_SIZE, DRAW_TIME }

class ResourceData:
	var ui_owner: Node2D
	var resources: Dictionary = {
		ResourceType.PEOPLE: 10,
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
		ResourceType.PEOPLE: 1,
		ResourceType.FOOD: 1,
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
		ExtraResourceType.HAND_SIZE: 10,
		ExtraResourceType.DRAW_SIZE: 1,
		ExtraResourceType.DRAW_TIME: 3.0
	}

	signal resources_changed

	func _init():
		emit_signal("resources_changed")
	func gain_resource(_resource_type: int, _amount: int):
		self.resources[_resource_type] += _amount * self.resource_mod[_resource_type]
		self.resources[_resource_type] = min(self.resources[_resource_type], self.resource_max[_resource_type])
		emit_signal("resources_changed")
		print("Resource %s changed by %s to %s" % [_resource_type, _amount, self.resources[_resource_type]])
	func spend_resource(_resource_type: int, _amount: int):
		self.resources[_resource_type] -= _amount
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
	func resource_tick():
		for resource in [ResourceType.PEOPLE, ResourceType.FOOD]:
			self.resources[resource] += self.resource_production[resource] - self.resource_maintenance[resource]
			self.resources[resource] = max(self.resources[resource], 0)
			self.resources[resource] = min(self.resources[resource], self.resource_max[resource])
		emit_signal("resources_changed")
		
