extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const cb = preload("res://Scripts/Content/Behaviors.gd")

class GoHunting extends cd.CardDataProperties:
    const res = preload("res://Scripts/Classes/ResourceData.gd")

    func _init():
        self.name = "Go hunting"
        self.wood_cost = 0
        self.gold_cost = 0
        self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
        self.behaviors = [
            cb.GainResourceBehavior.new(res.ResourceType.WOOD, 10)
        ]