enum CardBehaviorPriority { MIN, LOW, NORMAL, HIGH, MAX }
enum CardType { ACTION, BUILDING, ENVIRONMENT }
enum CardSubType { STATIC, DYNAMIC, ACTIVABLE }
enum CardZone { HAND, FIELD, DECK, DISCARD, SHOP }
enum CardRarity { COMMON, RARE, LEGENDARY}

class BaseCardZoneData:
	static func get_zone():
		return null

class HandCardZoneData extends BaseCardZoneData:
	var index: int
	func _init(_index: int):
		self.index = _index
	static func get_zone():
		return CardZone.HAND

class FieldCardZoneData extends BaseCardZoneData:
	var slot
	func _init(_slot):
		self.slot = _slot
	static func get_zone():
		return CardZone.FIELD

class DiscardCardZoneData extends BaseCardZoneData:
	static func get_zone():
		return CardZone.DISCARD

class DeckCardZoneData extends BaseCardZoneData:
	static func get_zone():
		return CardZone.DECK

class ShopCardZoneData extends BaseCardZoneData:
	static func get_zone():
		return CardZone.SHOP

class CardDataProperties:
	var name: String = "Unknown"
	var description: String = "Unknown"
	var rarity: int # <CardRarity>
	var ap_cost: int # 0, 1, 2, 3
	var wood_cost: int
	var draft_cost: int
	var duration: int = -1
	var cooldown: int = -1
	var card_type: int # <CardType>
	var card_subtype: int # <CardSubType>
	var artwork_path: String
	var behaviors: Array # <CardBehavior>

class CardData:
	const rd = preload("res://Scripts/Classes/ResourceData.gd") 

	var ui_owner: Node2D
	var name: String
	var description: String
	var rarity: int # <CardRarity>
	var type: int # <CardType>
	var subtype: int # <CardSubtype>
	var ap_cost: int
	var wood_cost: int
	var draft_cost: int
	var artwork: Resource
	var behaviors: Array # <CardBehavior>
	var zone_data: BaseCardZoneData

	var remaining_duration: float
	var max_duration: float

	var remaining_cooldown: float
	var max_cooldown: float

	signal entered_field(field_data)
	signal entered_hand
	signal entered_discard
	signal entered_deck

	signal duration_over
	signal cooldown_over

	static func sort_behaviors(_ba: CardBehavior, _bb: CardBehavior):
		return _ba.priority < _bb.priority

	func _init(_props: CardDataProperties):
		#print("Creating card: %s" % [_props.name, self.get_instance_id()])
		self.name = _props.name
		self.description = _props.description
		self.rarity = _props.rarity
		self.ap_cost = _props.ap_cost
		self.wood_cost = _props.wood_cost
		self.draft_cost = _props.draft_cost
		self.type = _props.card_type
		self.subtype = _props.card_subtype
		self.artwork = load(_props.artwork_path)
		self.behaviors = []
		for behavior in _props.behaviors:
			behavior.set_owner(self)
			#print("\t Attaching behavior: %s" % behavior)
			self.behaviors.append(behavior)
		self.behaviors.sort_custom(self, "sort_behaviors")
		if _props.duration > 0:
			self.max_duration = _props.duration
			self.remaining_duration = _props.duration
		if _props.cooldown > 0:
			self.max_cooldown = _props.cooldown
			self.remaining_cooldown = _props.cooldown
	func can_be_played():
		if State.state.resources.data.resources[rd.ResourceType.WOOD] < self.wood_cost:
			return false
		if State.state.resources.data.extra_resources[rd.ExtraResourceType.AP] < self.ap_cost:
			return false
		for behavior in self.behaviors:
			if not behavior.can_be_played():
				return false
		return true
	func update(delta):
		if self.zone_data.get_zone() != CardZone.FIELD:
			return
		if self.remaining_duration > 0:
			self.remaining_duration -= delta
			if self.remaining_duration <= 0:
				self.entered_discard()
				emit_signal("duration_over")
		if self.remaining_cooldown > 0:
			self.remaining_cooldown -= delta
			if self.remaining_cooldown <= 0:
				for behavior in self.behaviors:
					behavior.on_cooldown()
				self.remaining_cooldown = self.max_cooldown
				emit_signal("cooldown_over")
	func set_active(_active: bool):
		if not _active and State.state.current_card == self:
			State.state.current_card = null
		if _active:
			State.state.current_card = self
	func entered_field(_slot):
		State.state.resources.data.spend_resource(rd.ResourceType.WOOD, self.wood_cost)
		self.zone_data = FieldCardZoneData.new(_slot)
		emit_signal("entered_field", _slot)
		#yield(self.ui_owner, "entered_field_finished") # Wait for animations
		#print("Yielded")
		for behavior in self.behaviors:
			behavior.on_play()
		if self.max_cooldown > 0:
			self.remaining_cooldown = self.max_cooldown
		if self.max_duration > 0:
			self.remaining_duration = self.max_duration
	func entered_hand(_index):
		self.zone_data = HandCardZoneData.new(_index)
		emit_signal("entered_hand")
		#yield(self.ui_owner, "entered_hand_finished") # Wait for animations
		#print("Yielded")
		for behavior in self.behaviors:
			behavior.on_draw()
	func entered_discard():
		self.zone_data = DiscardCardZoneData.new()
		for behavior in self.behaviors:
			behavior.on_destroy()
		emit_signal("entered_discard")
	func entered_deck():
		self.zone_data = DeckCardZoneData.new()
		emit_signal("entered_deck")
	func play_as_action():
		State.state.resources.data.spend_resource(rd.ResourceType.WOOD, self.wood_cost)
		State.state.resources.data.change_extra_resource(rd.ExtraResourceType.AP, -self.ap_cost)
		#yield(self.ui_owner, "entered_field_finished") # Wait for animations
		#print("Yielded")
		for behavior in self.behaviors:
			behavior.on_play()

class CardBehavior:
	var owner: CardData
	var priority: int

	func _init(_priority=CardBehaviorPriority.NORMAL):
		self.priority = _priority
		self.owner = null
	func set_owner(_owner: CardData):
		self.owner = _owner
	func _to_string():
		return self.get_class()
	func on_play(_target=null):
		print("Triggered: on_play for %s targeting %s" % [self, _target])
	func on_discard():
		print("Triggered: on_discard for %s" % [self])
	func on_draw():
		print("Triggered: on_draw for %s" % [self])
	func on_destroy():
		print("Triggered: on_destroy for %s" % [self])
	func on_cooldown():
		print("Triggered: on_cooldown for %s" % [self])
	func on_activated():
		print("Triggered: on_activated for %s" % [self])
	func can_be_played():
		return true
