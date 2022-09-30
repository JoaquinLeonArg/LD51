
class GameState:
    const ge = preload("res://Scripts/Classes/GameEvent.gd")
    var player_hand: Array # <CardData>

    func _init():
        self.player_hand = []
    
    func event_handle(event_type: int, event_data: ge.GameEvent):
        pass