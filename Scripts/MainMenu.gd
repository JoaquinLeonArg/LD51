extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGameBtn_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")


func _on_OptionsBtn_pressed():
	print("TODO Options menu")
	pass # Replace with function body.


func _on_CreditsBtn_pressed():
	print("TODO Credits menu")
	pass # Replace with function body.


func _on_QuitBtn_pressed():
	get_tree().quit()
	
	pass # Replace with function body.
