class DeckData:
    var cards: Array = [] # <Card>

    func shuffle():
        self.cards.shuffle()
    # func draw(_count: int):
    #     for i in range(_count):
    #         if State.state.hand.ui_owner.