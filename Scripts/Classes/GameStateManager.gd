extends Node


class State:
    const cd = preload("res://Scripts/Classes/CardData.gd")
    const df = preload("res://Scripts/Classes/Difficulty.gd")

    var current_card = null
    var field = null
    var hand = null
    var resources = null
    var seasons = null
    var deck = null
    var difficulty = df.Difficulty.EASY

var state = State.new()