extends Node

const rd = preload("res://Scripts/Classes/ResourceData.gd")

enum Difficulty {
    EASY,
    NORMAL,
    HARD
}

var starting_resources: Dictionary = {
    Difficulty.EASY: {
        rd.ResourceType.PEOPLE: 10,
        rd.ResourceType.FOOD: 10,
        rd.ResourceType.WOOD: 10,
        rd.ResourceType.GOLD: 10,
    }
}