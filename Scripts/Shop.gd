extends Node2D

# Imports
const sd = preload("res://Scripts/Classes/SeasonData.gd")


# Properties
var button_hovering: bool = false
var hide_hovering: bool = false
var hidden = false
var options: Array

# Methods
func _ready():
	State.state.shop = self
	self.global_position.y = -1000
	self.visible = true
	self.options = $Options.get_children()

	var _x
	_x = $ColorRect/ExitButton.connect("mouse_entered", self, "on_mouse_entered_button")
	_x = $ColorRect/ExitButton.connect("mouse_exited", self, "on_mouse_exited_button")
	_x = $HideButton.connect("mouse_entered", self, "on_mouse_entered_hide")
	_x = $HideButton.connect("mouse_exited", self, "on_mouse_exited_hide")

func initialize():
	for option in self.options:
		option.initialize()

func show():
	for option in self.options:
		option.refresh()
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 0.2)

func close():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, -1000), 0.2)
	State.state.paused = false
	if State.state.seasons.data.season == sd.Season.DRAFT:
		State.state.seasons.data.season_progress = 10

func _process(_delta):
	if self.button_hovering:
		$ColorRect/ExitButton.color = "#55cc55"
	else:
		$ColorRect/ExitButton.color = "228822"
	if self.hide_hovering:
		$HideButton.color = "#cacaca"
	else:
		$HideButton.color = "a3a3a3"

func _input(event):
	if event.is_action_pressed("left_click") and self.button_hovering:
		Sound.sound.play_effect("ui_click")	
		self.close()
	if event.is_action_pressed("left_click") and self.hide_hovering:
		Sound.sound.play_effect("ui_click")			
		if self.hidden:
			self.hidden = false
			$ColorRect.visible = true
			$Options.visible = true
			$HideButton/HideButtonText.bbcode_text = "[center]HIDE[/center]"
		else:
			self.hidden = true
			$ColorRect.visible = false
			$Options.visible = false
			$HideButton/HideButtonText.bbcode_text = "[center]SHOW[/center]"

func on_mouse_entered_button():
	Sound.sound.play_effect("hover")	
	self.button_hovering = true

func on_mouse_exited_button():
	self.button_hovering = false

func on_mouse_entered_hide():
	Sound.sound.play_effect("hover")	
	self.hide_hovering = true

func on_mouse_exited_hide():
	self.hide_hovering = false
