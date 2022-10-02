class DiscardData:
    var cards: Array = [] # <Card>

    signal updated_cards

    func add_card(card):
        self.cards.append(card)
        emit_signal("updated_cards")