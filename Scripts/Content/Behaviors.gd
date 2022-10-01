extends Node

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")
const rd = preload("res://Scripts/Classes/ResourceData.gd")

class GainResourceBehavior extends cd.CardBehavior:
    const cd = preload("res://Scripts/Classes/CardData.gd")

    var resource_type: int
    var amount: int
    func _init(_resource_type: int, _amount: int).(cd.CardBehaviorPriority.NORMAL):
        self.resource_type = _resource_type
        self.amount = _amount

    func _to_string():
        return self.get_class()
    func on_play(_target=null):
        .on_play()
        State.state.resources.data.gain_resource(self.resource_type, self.amount)
    func can_be_played():
        return true
    