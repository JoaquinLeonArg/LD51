extends Node2D

func _ready():
	State.state.discard = self
	
