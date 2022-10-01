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
    func on_play(_target=null):
        .on_play()
        State.state.resources.data.gain_resource(self.resource_type, self.amount)

class StaticHandSizeBehavior extends cd.CardBehavior:
    const rd = preload("res://Scripts/Classes/ResourceData.gd")

    var amount: int

    func _init(_amount: int).(cd.CardBehaviorPriority.NORMAL):
        self.amount = _amount
    func on_play(_target=null):
        .on_play()
        State.state.resources.data.change_extra_resource(rd.ExtraResourceType.HAND_SIZE, self.amount)
    func on_destroy():
        .on_destroy()
        State.state.resources.data.change_extra_resource(rd.ExtraResourceType.HAND_SIZE, -self.amount)