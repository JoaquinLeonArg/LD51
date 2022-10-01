class DeckData:
    const rd = preload("res://Scripts/Classes/ResourceData.gd")

    var cards: Array = [] # <Card>

    signal updated_cards(card_count)

    func shuffle():
        self.cards.shuffle()
    func draw(_count: int):
        for _i in range(_count):
            if len(State.state.hand.data.cards) < State.state.resources.data.extra_resources[rd.ExtraResourceType.HAND_SIZE]:
                var card = self.cards.pop_front()
                State.state.hand.add_card(card)
        emit_signal("updated_cards", len(self.cards))