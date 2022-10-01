extends Node2D

var hovering: bool = false

func _ready():
	State.state.field = self
	var _x
	_x = $ActionArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $ActionArea.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	self.hovering = true

func on_mouse_exited():
	self.hovering = false