enum SlotType {SLOT_A, SLOT_B}
enum SlotModifier { FARM_PROD, WOOD_PROD }


class PlaySlotData:
    const cd = preload("res://Scripts/Classes/CardData.gd")
    const rd = preload("res://Scripts/Classes/ResourceData.gd")

    var slot_type: int # <SlotType>
    var index: int
    var card: cd.CardData
    var locked = false

    var modifiers = {
        SlotModifier.FARM_PROD: 1.0,
        SlotModifier.WOOD_PROD: 1.0,
    }

    signal unlock
    signal lock

    func _init(_slot_type: int, _index: int):
        self.slot_type = _slot_type
        self.index = _index
        #print("Slot initialized: %s (%s %s)" % [self.get_instance_id(), self.slot_type, self.index])
    func lock():
        self.locked = true
        emit_signal("lock")
    func unlock():
        if self.locked and State.state.resources.data.resources[rd.ResourceType.GOLD] >= 10:
            self.locked = false
            State.state.resources.data.spend_resource(rd.ResourceType.GOLD, 10)
            emit_signal("unlock")