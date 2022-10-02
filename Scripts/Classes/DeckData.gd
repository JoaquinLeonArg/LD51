class DeckData:
    const rd = preload("res://Scripts/Classes/ResourceData.gd")
    const cd = preload("res://Scripts/Classes/CardData.gd")

    var cards: Array = [] # <Card>

    signal updated_cards

    func shuffle():
        self.cards.shuffle()
    func draw(_count: int):
        for _i in range(_count):
            if len(State.state.hand.data.cards) < State.state.resources.data.extra_resources[rd.ExtraResourceType.HAND_SIZE]:
                if len(self.cards) == 0 and len(State.state.discard.data.cards) > 0:
                    self.reshuffle()
                if len(self.cards) == 0:
                    break
                var card = self.cards.pop_back()
                State.state.hand.add_card(card)
                card.flip(0.2)
            
        emit_signal("updated_cards")
    func draw_action():
        self.draw(State.state.resources.data.extra_resources[rd.ExtraResourceType.DRAW_SIZE])
    func reshuffle():
        while true:
            var card = State.state.discard.data.cards.pop_back()
            if not card:
                break
            State.state.deck.add_card(card)
            State.state.deck.cards.shuffle()
            card.flip(0.2)