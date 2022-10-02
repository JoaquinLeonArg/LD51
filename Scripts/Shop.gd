extends Node2D

# Imports

# Properties
var button_hovering: bool = false

# Methods
func _ready():
	var _x
	_x = $ColorRect/ExitButton.connect("mouse_entered", self, "on_mouse_entered_button")
	_x = $ColorRect/ExitButton.connect("mouse_exited", self, "on_mouse_exited_button")

func _process(_delta):
	if self.button_hovering:
		$ColorRect/ExitButton.color = "#55cc55"
		return
	else:
		$ColorRect/ExitButton.color = "228822"

func _input(event):
	if event.is_action_pressed("left_click") and self.button_hovering:
		queue_free()

func on_mouse_entered_button():
	self.button_hovering = true

func on_mouse_exited_button():
	self.button_hovering = false