extends Node2D

var icons = {
	3: preload("res://RawResources/Graphics/coin_ico.png"),
	1: preload("res://RawResources/Graphics/food_ico.png"),
	2: preload("res://RawResources/Graphics/wood_ico.png"),
	0: preload("res://RawResources/Graphics/person.png"),
}

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.tween_callback(self, "queue_free")

func set_data(resource, amount):
	$Sprite.texture = self.icons[resource]
	$Text.bbcode_text = "[center]%s[/center]" % amount