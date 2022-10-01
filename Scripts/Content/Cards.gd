extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const cb = preload("res://Scripts/Content/Behaviors.gd")

enum CardDraftCost {
	COMMON = 100,
	RARE = 500,
	LEGENDARY = 1000
}

enum CardBuildCost {
	COMMON = 100,
	RARE = 300,
	LEGENDARY = 500
}

class GoHuntingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Go hunting"
		self.description = "Gain food instantly."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.COMMON
		self.card_type = cd.CardType.ACTION
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 100),
		]

class DangerousMiningCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Dangerous Mining"
		self.description = "Go on an epic mining session to bring a ton of gold (100 people will die though)."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.LEGENDARY
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 500),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100)
		]

class GatherWoodCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Gather Wood"
		self.description = "Gain wood instantly."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.COMMON
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 100),
		]
		
class GoldRushCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Gold Rush"
		self.description = "Gain gold instantly."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.RARE
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
		]

class MigratePeopleCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Migrate People"
		self.description = "100 people immigrates to your village instantly."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.RARE
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, 100),
		]

class IntermitentFastingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Intermitent Fasting"
		self.description = "Brings the secrets of the fitness community to halve food consumption for the rest of the season."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.LEGENDARY
		self.card_type = cd.CardType.ACTION
		self.duration = 10
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.FOOD, 0.5), # 50% food consumption for 10 seconds
		]

class HuntMammothCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Hunt Mammoth"
		self.description = "Go on an epic hunting session to provide a ton of food (100 people will die though)."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.LEGENDARY
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 500),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100)
		]

class HireIllegalBulldozerCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Hire Illegal Bulldozer"
		self.description = "Go on an illegal deforestation session to provide a ton of wood (100 people against this attack to mother nature will die though)."
		self.wood_cost = 0
		self.draft_cost = CardDraftCost.LEGENDARY
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 500),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100)
		]

class FunHouseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Fun House"
		self.description = "Do (probably illegal) stuff to generate gold on demand in exchange of 100 people's lives."
		self.wood_cost = CardBuildCost.COMMON
		self.draft_cost = CardDraftCost.COMMON
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
		self.description = "Sell 100 wood in exchange for gold on demand."
		self.wood_cost = CardBuildCost.COMMON
		self.draft_cost = CardDraftCost.COMMON
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
		self.description = "Increases all your max resources by 100."
		self.wood_cost = CardBuildCost.COMMON
		self.draft_cost = CardDraftCost.COMMON
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
		self.description = "Boost food production by 25%."
		self.wood_cost = CardBuildCost.RARE
		self.draft_cost = CardDraftCost.RARE
		self.card_subtype = cd.CardSubType.STATIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.FOOD, 0.25),
		]
		

class CarpentryShopCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Carpentry Shop"
		self.description = "Boost wood production by 25%."
		self.wood_cost = CardBuildCost.RARE
		self.draft_cost = CardDraftCost.RARE
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
		self.description = "Boost gold production by 25%."
		self.wood_cost = CardBuildCost.LEGENDARY
		self.draft_cost = CardDraftCost.RARE
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
		self.description = "Generates food per second."
		self.wood_cost = CardBuildCost.COMMON
		self.draft_cost = CardDraftCost.COMMON
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DynamicBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 50),
			])
		]

class LumberCampCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Lumber Camp"
		self.description = "Generates wood per second."
		self.wood_cost = CardBuildCost.COMMON
		self.draft_cost = CardDraftCost.COMMON
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
		self.description = "Add one extra card to your max cards in your godly hand."
		self.wood_cost = CardBuildCost.LEGENDARY
		self.draft_cost = CardDraftCost.COMMON
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.StaticHandSizeBehavior.new(1)
		]

class MiningCampCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Mining Camp"
		self.description = "Generates gold per second."
		self.wood_cost = CardBuildCost.RARE
		self.draft_cost = CardDraftCost.COMMON
		self.card_subtype = cd.CardSubType.DYNAMIC
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DynamicBehavior.new([
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 100),
			])
		]
