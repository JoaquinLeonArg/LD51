extends Node2D

# Constants


# Imports
const sd = preload("res://Scripts/Classes/SeasonData.gd")

# Instance properties
var data: sd.SeasonData
var season_names: Dictionary = {
		sd.Season.SPRING: "SPRING",
		sd.Season.SUMMER: "SUMMER",
		sd.Season.AUTUMN: "AUTUMN",
		sd.Season.WINTER: "WINTER",
		sd.Season.DRAFT: "SHOP"
	}

# Methods
func _ready():
	self.data = sd.SeasonData.new()
	State.state.seasons = self
	var _x
	_x = self.data.connect("update_ui", self, "update_ui")

func _process(delta):
	self.data.update(delta)
	$Progress.value = self.data.season_progress

func update_ui(season, year):
	$YearText.bbcode_text = "[center]YEAR %s[/center]" % year
	$SeasonText.bbcode_text = "[center]%s[/center]" % self.season_names[season]
 
