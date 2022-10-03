# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const cb = preload("res://Scripts/Content/Behaviors.gd")

enum CardDraftCost {
	COMMON = 5,
	RARE = 10,
	LEGENDARY = 20
}

enum CardBuildCost {
	COMMON = 5,
	RARE = 10,
	LEGENDARY = 20
}

class WoodlandCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Woodland"
		self.description = "Gain 1 wood each year."
		self.ap_cost = 0
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 0
		self.card_type = cd.CardType.ENVIRONMENT
		self.behaviors = [
			cb.YearChangeResourceBehavior.new(res.ResourceType.WOOD, 1),
		]

class LakeCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Lake"
		self.description = "Gain 1 food each season for each adjacent building."
		self.ap_cost = 0
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 0
		self.card_type = cd.CardType.ENVIRONMENT
		self.behaviors = [
			cb.SeasonChangeResourceByAdjacencyBehavior.new(res.ResourceType.FOOD, 1),
		]

class GoHuntingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Hunters"
		self.description = "[b]Play[/b]: Gain 5 food."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 3
		self.card_type = cd.CardType.ACTION
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 5),
		]

class DangerousMiningCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Miners"
		self.description = "[b]Play[/b]: Gain 1 gold."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 3
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 500),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -100)
		]

class ResearchCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Research"
		self.description = "[b]Play[/b]: Draw 2 cards."
		self.ap_cost = 0
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 5
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DrawCardsBehavior.new(2)
		]

class HighResearchCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "High Research"
		self.description = "[b]Play[/b]: Draw 3 cards."
		self.ap_cost = 0
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 10
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DrawCardsBehavior.new(4)
		]

class ExpertiseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Expertise"
		self.description = "[b]Play[/b]: Draw 4 cards."
		self.ap_cost = 0
		self.rarity = cd.CardRarity.LEGENDARY
		self.draft_cost = 20
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DrawCardsBehavior.new(4)
		]

class GatherWoodCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Lumberjacks"
		self.description = "[b]Play[/b]: Destroy a random woodland.\nGain 3 wood."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 1
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.OnCardUseSoundBehavior.new("gather_wood"),
			cb.DestroyTypeBuildingBehavior.new("Woodland"),
			cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, 3),
		]
		
class GoldRushCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Gold Rush"
		self.description = "[b]Play[/b]: Gain 2 gold."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 3
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 2),
		]

class MigratePeopleCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "New Arrivals"
		self.description = "[b]Play[/b]: Gain 10 people."
		self.ap_cost = 2
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 3
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, 10),
		]

class IntermitentFastingCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Fasting Cult"
		self.description = "Halves food consumption.\nLasts 10 seconds."
		self.wood_cost = 0
		self.draft_cost = 5
		self.rarity = cd.CardRarity.RARE
		self.card_type = cd.CardType.BUILDING
		self.duration = 10
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.FOOD, 0.5), # 50% food consumption for 10 seconds
		]

class HuntMammothCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Mammoth Pack"
		self.description = "[b]Play[/b]: Gain 30 food. Lose 5 people."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 5
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeResourceBehavior.new(res.ResourceType.FOOD, 30),
			cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -5)
		]

class HireIllegalBulldozerCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Deforestation"
		self.description = "[b]Play[/b]: Destroy all woodlands. Gain 10 wood for each one destroyed."
		self.ap_cost = 2
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 10
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.DeforestationBehavior.new()
		]

class ReforestationCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Reforestation"
		self.description = "[b]Play[/b]: Create two Woodlands at random locations."
		self.ap_cost = 1
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 5
		self.card_type = cd.CardType.ACTION
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ReforestationBehavior.new(WoodlandCard)
		]

class FunHouseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Bar"
		self.description = "[b]Click, 1 people[/b]: Gain 2 gold. Medium cooldown"
		self.wood_cost = 10
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 5
		self.cooldown = 5
		self.card_subtype = cd.CardSubType.ACTIVABLE
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ClickBehavior.new([
				cb.OnCardInteractionSoundBehavior.new("cash_register"),
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 2),
				cb.ChangeResourceBehavior.new(res.ResourceType.PEOPLE, -1),
			]),
		]

class TradingPostCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Trading Post"
		self.description = "[b]Click, 5 wood[/b]: Gain 1 gold. Short cooldown."
		self.wood_cost = 15
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 5
		self.cooldown = 1
		self.card_subtype = cd.CardSubType.ACTIVABLE
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ClickBehavior.new([
				cb.OnCardInteractionSoundBehavior.new("cash_register"),
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 1),
				cb.ChangeResourceBehavior.new(res.ResourceType.WOOD, -5),
			]),
			cb.HasResourceBehavior.new(res.ResourceType.WOOD, 5)
		]

class StorageCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Storage"
		self.description = "Increases all your max resources by 10."
		self.wood_cost = 5
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 1
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.GOLD, 10),
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.WOOD, 10),
			cb.ChangeMaxResourceBehavior.new(res.ResourceType.FOOD, 10),
		]

class TownCenterCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Town Center"
		self.description = "Increases your max AP by 1."
		self.wood_cost = 5
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 1
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeExtraResourceBehavior.new(res.ExtraResourceType.AP_MAX, 1),
		]

class MillCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

	func _init():
		self.name = "Mill"
		self.description = "Boost adjacent Farms production by 100%."
		self.wood_cost = 20
		self.rarity = cd.CardRarity.LEGENDARY
		self.draft_cost = 10
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeAdjacentSlotsModifier.new(psd.SlotModifier.FARM_PROD, 1.0),
			# TODO: Add this to farms
		]
		

class CarpentryShopCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")
	const psd = preload("res://Scripts/Classes/PlaySlotData.gd")

	func _init():
		self.name = "Carpentry Shop"
		self.description = "Boost adjacent Woodlands and Lumber Camps production by 100%."
		self.wood_cost = 10
		self.rarity = cd.CardRarity.LEGENDARY
		self.draft_cost = 10
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeAdjacentSlotsModifier.new(psd.SlotModifier.WOOD_PROD, 1.0),
			# TODO: Add this to woodlands
		]

class BankCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Bank"
		self.description = "Boost gold production by 50%."
		self.wood_cost = 30
		self.rarity = cd.CardRarity.LEGENDARY
		self.draft_cost = 10
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeModifierBehavior.new(res.ResourceType.GOLD, 0.5),
		]

class FarmCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Farm"
		self.description = "Gain 5 food each season, +1 for each upgrade.\n[b]Click, 3 gold[/b]: Upgrade."
		self.cooldown = 0.5
		self.max_upgrade = 3
		self.wood_cost = 10
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 8
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.FarmBehavior.new(),
			cb.ClickBehavior.new([
				cb.OnCardInteractionSoundBehavior.new("cash_register"),
				cb.UpgradeBehavior.new(3)
			])
		]

class LumberCampCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Lumber Camp"
		self.description = "Gain 3 wood each season, +2 for each upgrade.\n[b]Click, 3 gold[/b]: Upgrade."
		self.cooldown = 0.5
		self.max_upgrade = 3
		self.wood_cost = 10
		self.rarity = cd.CardRarity.COMMON
		self.draft_cost = 8
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.LumberCampBehavior.new(),
			cb.ClickBehavior.new([
				cb.OnCardInteractionSoundBehavior.new("gather_wood"),
				cb.UpgradeBehavior.new(3)
			])
		]

class HouseCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "House"
		self.description = "Gain 1 extra hand size."
		self.wood_cost = 5
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 3
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ChangeExtraResourceBehavior.new(res.ExtraResourceType.HAND_SIZE, 1)
		]

class MiningCampCard extends cd.CardDataProperties:
	const res = preload("res://Scripts/Classes/ResourceData.gd")

	func _init():
		self.name = "Gold Mine"
		self.description = "[b]Click[/b]: Gain 1 gold, +1 for each upgrade. Then, upgrade. Long cooldown."
		self.cooldown = 15
		self.max_upgrade = 3
		self.wood_cost = 10
		self.rarity = cd.CardRarity.RARE
		self.draft_cost = 5
		self.card_type = cd.CardType.BUILDING
		self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
		self.behaviors = [
			cb.ClickBehavior.new([
				cb.OnCardInteractionSoundBehavior.new("cash_register"),
				cb.UpgradeBehavior.new(0),
				cb.ChangeResourceBehavior.new(res.ResourceType.GOLD, 3, 1),
			])
		]

var all_cards = [
	GoHuntingCard,
	DangerousMiningCard,
	ResearchCard,
	HighResearchCard,
	ExpertiseCard,
	GatherWoodCard,
	GoldRushCard,
	MigratePeopleCard,
	IntermitentFastingCard,
	HuntMammothCard,
	HireIllegalBulldozerCard,
	ReforestationCard,
	FunHouseCard,
	TradingPostCard,
	StorageCard,
	TownCenterCard,
	MillCard,
	CarpentryShopCard,
	BankCard,
	FarmCard,
	LumberCampCard,
	HouseCard,
	MiningCampCard
]
