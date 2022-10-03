extends VBoxContainer


func _on_NewGameBtn_pressed():
	Sound.sound.play_effect("ui_click")
	get_tree().change_scene("res://Scenes/GameScene.tscn")


func _on_OptionsBtn_pressed():
	Sound.sound.play_effect("ui_click")
	#State.state.sound().play()
	# get_tree().change_scene("res://Scenes/OptionsScene.tscn")


func _on_CreditsBtn_pressed():
	Sound.sound.play_effect("ui_click")	
	get_tree().change_scene("res://Scenes/CreditsScene.tscn")

func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_QuitBtn_mouse_entered():
	Sound.sound.play_effect("hover")

func _on_CreditsBtn_mouse_entered():
	Sound.sound.play_effect("hover")

func _on_NewGameBtn_mouse_entered():
	Sound.sound.play_effect("hover")


func _on_HowToPlayBtn_pressed():
	Sound.sound.play_effect("ui_click")	
	get_tree().change_scene("res://Scenes/HowToPlayScene.tscn")


func _on_HowToPlayBtn_mouse_entered():
	Sound.sound.play_effect("hover")
