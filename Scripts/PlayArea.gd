extends Node2D

onready var actions_area: ColorRect = $ActionArea

func _ready():
	State.state.field = self
	
