extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_BackToMenu_mouse_entered():
	Sound.sound.play_effect("hover")

func _on_BackToMenu_pressed():
	Sound.sound.play_effect("ui_click")
	get_tree().change_scene("res://Scenes/MainMenuScene.tscn")
