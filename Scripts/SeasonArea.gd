extends Node2D

# Constants


# Imports
const sd = preload("res://Scripts/Classes/SeasonData.gd")

# Instance properties
var data: sd.SeasonData

# Methods
func _ready():
	self.data = sd.SeasonData.new()
	State.state.seasons = self

func _process(delta):
	self.data.season_progress += delta
	$Progress.value = self.data.season_progress