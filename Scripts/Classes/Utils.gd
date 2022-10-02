extends Node

const card_component = preload("res://Components/Card.tscn")
const cd = preload("res://Scripts/Classes/CardData.gd")

func create_card(card_data, zone_data):
    var card_props = card_data.new()
    var card = card_component.instance()
    card.set_data(cd.CardData.new(card_props))
    card.data.ui_owner = card
    card.data.zone_data = zone_data
    if zone_data.get_zone() == cd.CardZone.HAND:
        State.state.hand.data.add_card(card)
    if zone_data.get_zone() == cd.CardZone.DECK:
        State.state.deck.add_card(card)
        card.global_position = State.state.deck.global_position
        card.flip(0)