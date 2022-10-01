extends Node2D

var hovering: bool = false

func _ready():
	State.state.field = self
	var _x
	_x = $ActionArea.connect("mouse_entered", self, "on_mouse_entered")
	_x = $ActionArea.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	$ActionArea.modulate.a = 0.5
	self.hovering = true

func on_mouse_exited():
	$ActionArea.modulate.a = 0.0
	self.hovering = false
