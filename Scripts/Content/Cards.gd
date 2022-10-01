extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const cb = preload("res://Scripts/Content/Behaviors.gd")

class GoHuntingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Go hunting"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 100),
		]

class DangerousMiningCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Dangerous Mining"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100)
		]

class GatherWoodCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Gather Wood"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 100),
		]
		
class GoMiningCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Go Mining"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
		]

class MigratePeopleCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Migrate People"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, 100),
		]

class IntermitentFastingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Intermitent Fasting"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.BUILDING
		self.card_subtype = cd.CardSubtype.STATIC
		self.duration = 10
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.FOOD, 0.5), # 50% food for 10 seconds
		]

class HuntMammothCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Hunt Mammoth"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 100),
		]

class HireIllegalBulldozerCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Hire Illegal Bulldozer"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 100),
		]

class FunHouseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Fun House"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_type = cd.CardType.BUILDING
		self.card_subtype = cd.CardSubType.ACTIVABLE
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ClickBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
				cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100),
			]),
		]

class TradingPostCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Trading Post"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.ACTIVABLE
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ClickBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
				cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, -100),
			]),
		]

class StorageCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Storage"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.ACTIVABLE
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.GOLD, 100),
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.WOOD, 100),
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.FOOD, 100),
		]

class MillCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Mill"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.STATIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.FOOD, 0.25),
		]
		

class BlacksmithCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Blacksmith"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.STATIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.WOOD, 0.25),
		]

class BankCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Bank"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.STATIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.GOLD, 0.25),
		]

class FarmCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Farm"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DynamicBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 100),
			])
		]

class LumberCampCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Lumber Camp"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DynamicBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 100),
			])
		]

class HouseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "House"
		self.wood_cost = 0
		self.gold_cost = 0
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.StaticHandSizeBehavior.new(1)
		]