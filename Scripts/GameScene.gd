extends Node2D

func _ready():
	randomize()
	State.state.start_game()
	State.state.shop.initialize()
	State.state.field.initialize()
	Sound.sound.play_music("winter")


func _on_Button_mouse_entered():
	Sound.sound.play_effect("hover")
