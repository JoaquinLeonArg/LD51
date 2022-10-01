enum CardBehaviorPriority {MIN, LOW, NORMAL, HIGH, MAX}
enum CardType {}
enum CardSubtype {}
enum CardZone {HAND, FIELD}

class BaseCardZoneData:
    static func get_zone():
        return null

class HandCardZoneData  extends BaseCardZoneData:
    var index: int
    static func get_zone():
        return CardZone.HAND

class FieldCardZoneData extends BaseCardZoneData:
    var slot
    func _init(_slot):
        self.slot = _slot
    static func get_zone():
        return CardZone.FIELD
    

class CardDataProperties:
    var name: String = "Unknown"
    var cost: int
    var artwork_path: String
    var behaviors: Array # <CardBehavior>
    func _init():
        pass

class CardData:
    var ui_owner: Node2D
    var name: String
    var type: int # <CardType>
    var subtypes: Array # <CardSubtype>
    var cost: int
    var artwork: Resource
    var behaviors: Array # <CardBehavior>
    var zone_data: BaseCardZoneData

    signal entered_field(field_data)
    signal entered_hand
    signal entered_discard
    signal entered_deck

    static func sort_behaviors(_ba: CardBehavior, _bb: CardBehavior):
        return _ba.priority < _bb.priority

    func _init(_props: CardDataProperties):
        print("Creating card: %s (%s)" % [_props.name, self.get_instance_id()])
        self.name = _props.name
        self.cost = _props.cost
        self.artwork = load(_props.artwork_path)
        self.behaviors = []
        for behavior in _props.behaviors:
            behavior.set_owner(self)
            print("\t Attaching behavior: %s" % behavior)
            self.behaviors.append(behavior)
        self.behaviors.sort_custom(self, "sort_behaviors")
    func can_be_played():
        for behavior in self.behaviors:
            if not behavior.can_be_played():
                return false
        return true
    func set_active(_active: bool):
        if not _active and State.state.current_card == self:
            State.state.current_card = null
        if _active:
            State.state.current_card = self
    func entered_field(_slot):
        self.zone_data = FieldCardZoneData.new(_slot)
        emit_signal("entered_field", _slot)
        #yield(self.ui_owner, "entered_field_finished") # Wait for animations
        print("Yielded")
        for behavior in self.behaviors:
            behavior.on_play()
    func entered_hand():
        self.zone_data = HandCardZoneData.new()
        emit_signal("entered_hand")
        #yield(self.ui_owner, "entered_hand_finished") # Wait for animations
        print("Yielded")
        for behavior in self.behaviors:
            behavior.on_draw()
    func entered_discard():
        # TODO
        emit_signal("entered_discard")
    func entered_deck():
        # TODO
        emit_signal("entered_deck")

class CardBehavior:
    var owner: CardData
    var priority: int

    func _init(_priority=CardBehaviorPriority.NORMAL):
        self.priority = _priority
    func set_owner(_owner: CardData):
        self.owner = _owner
    func _to_string():
        return self.get_class()
    func on_play(_target=null):
        print("Triggered: on_play for %s on card %s (%s) targeting %s" % [self, self.owner.name, self.owner.get_instance_id(), _target])
    func on_discard():
        print("Triggered: on_discard for %s on card %s (%s)" % [self, self.owner.name, self.owner.get_instance_id()])
    func on_draw():
        print("Triggered: on_draw for %s on card %s (%s)" % [self, self.owner.name, self.owner.get_instance_id()])
    func can_be_played():
        return true