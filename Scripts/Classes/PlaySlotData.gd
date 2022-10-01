enum SlotType {SLOT_A, SLOT_B}

class PlaySlotData:
    const cd = preload("res://Scripts/Classes/CardData.gd")

    var slot_type: int # <SlotType>
    var index: int
    var card: cd.CardData
    func _init(_slot_type: int, _index: int):
        self.slot_type = _slot_type
        self.index = _index
        print("Slot initialized: %s (%s %s)" % [self.get_instance_id(), self.slot_type, self.index])