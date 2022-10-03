extends VBoxContainer

func _on_NewGameBtn_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")


func _on_OptionsBtn_pressed():
	get_tree().change_scene("res://Scenes/OptionsScene.tscn")


func _on_CreditsBtn_pressed():
	get_tree().change_scene("res://Scenes/CreditsScene.tscn")


func _on_QuitBtn_pressed():
	get_tree().quit()
