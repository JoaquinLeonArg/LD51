extends Node


class State:
    const cd = preload("res://Scripts/Classes/CardData.gd")
    const df = preload("res://Scripts/Classes/Difficulty.gd")

    const content_cards = preload("res://Scripts/Content/Cards.gd")

    var current_card = null
    var field = null
    var hand = null
    var resources = null
    var seasons = null
    var deck = null
    var discard = null
    var difficulty = df.Difficulty.EASY

    func start_game():
        var deck_cards = [
            content_cards.GoHuntingCard,
            content_cards.GatherWoodCard,
            content_cards.GoldRushCard,
            content_cards.GoHuntingCard,
            content_cards.GatherWoodCard,
            content_cards.GoldRushCard,
            content_cards.GoldRushCard,
            content_cards.FarmCard,
            content_cards.LumberCampCard,
            content_cards.MiningCampCard
        ]
        for i in range(len(deck_cards)):
            Utils.create_card(deck_cards[i], cd.DeckCardZoneData.new())
        self.deck.data.draw(3)
        

var state = State.new()