extends Node2D

func _ready():
	$Background.modulate.a = 0
	var tween = create_tween()
	tween.tween_property($Background, "modulate:a", 0.8, 1)

func _input(event):
	if event.is_class("InputEventKey"):
		get_tree().change_scene("res://Scenes/MainMenuScene.tscn")
