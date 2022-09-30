enum GameEventType {
    CARD_PLAYED,
    CARD_DRAWN,
    RESOURCE_CHANGED
}

class GameEvent:
    const cd = preload("res://Scripts/Classes/CardData.gd")
    var event_type: int # <GameEventType>

class CardPlayedEvent extends GameEvent:
    var card
    func _init(_card: cd.CardData):
        self.event_type = GameEventType.CARD_PLAYED
        self.card = card

class CardDrawnEvent extends GameEvent:
    var card
    func _init(_card: cd.CardData):
        self.event_type = GameEventType.CARD_DRAWN
        self.card = card

class ResourceChangedEvent extends GameEvent:
    var type
    var change
    var is_absolute
    func _init(_type, _change, _is_absolute=false):
        self.event_type = GameEventType.RESOURCE_CHANGED
        self.type = _type
        self.change = _change
        self.is_absolute = _is_absolute