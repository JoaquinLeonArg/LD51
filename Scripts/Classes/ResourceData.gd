enum ResourceType { PEOPLE, FOOD, WOOD, GOLD }
enum ExtraResourceType { HAND_SIZE }

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
		ResourceType.FOOD: 3,
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
		ExtraResourceType.HAND_SIZE: 3
	}

	signal resource_value_changed(resource_type, old_amount, new_amount)
	signal resource_change_changed(resource_type, old_amount, new_amount)
	signal extra_resource_value_changed(resource_type, old_amount, new_amount)

	func _init():
		print("Resource system starting up")
	func gain_resource(_resource_type: int, _amount: int):
		var old = self.resources[_resource_type]
		self.resources[_resource_type] += _amount * self.resource_mod[_resource_type]
		self.resources[_resource_type] = min(self.resources[_resource_type], self.resource_max[_resource_type])
		emit_signal("resource_value_changed", _resource_type, old, self.resources[_resource_type])
		print("Resource %s changed from %s to %s" % [_resource_type, old, self.resources[_resource_type]])
	func spend_resource(_resource_type: int, _amount: int):
		var old = self.resources[_resource_type]
		self.resources[_resource_type] -= _amount
		self.resources[_resource_type] = max(self.resources[_resource_type], 0)
		emit_signal("resource_value_changed", _resource_type, old, self.resources[_resource_type])
	func change_extra_resource(_resource_type: int, _change: int):
		var old = self.extra_resources[_resource_type]
		self.extra_resources[_resource_type] += _change
		emit_signal("extra_resource_value_changed", _resource_type, old, self.extra_resources[_resource_type])
	func resource_tick():
		for resource in [ResourceType.PEOPLE, ResourceType.FOOD]:
			var old = self.resources[resource]
			self.resources[resource] += self.resource_production[resource] - self.resource_maintenance[resource]
			self.resources[resource] = max(self.resources[resource], 0)
			self.resources[resource] = min(self.resources[resource], self.resource_max[resource])
			emit_signal("resource_value_changed", resource, old, self.resources[resource])
		
