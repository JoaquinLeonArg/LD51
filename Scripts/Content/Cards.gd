extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const cb = preload("res://Scripts/Content/Behaviors.gd")

class CardTest extends cd.CardDataProperties:
    const res = preload("res://Scripts/Classes/ResourceData.gd")

    func _init():
        self.name = "Test card"
        self.cost = 2
        self.artwork_path = "res://RawResources/Graphics/art_test.jpg"
        self.behaviors = [
            cb.GainResourceBehavior.new(res.ResourceType.WOOD, 10)
        ]