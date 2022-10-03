extends Node2D

func _ready():
	State.state.start_game()
	State.state.shop.initialize()
	State.state.field.initialize()


func _on_Button_mouse_entered():
	Sound.sound.play_effect("hover")
