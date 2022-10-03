extends Node2D

func _ready():
	State.state.start_game()
	State.state.shop.initialize()
	State.state.field.initialize()
