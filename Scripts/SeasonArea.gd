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
var season_colors: Dictionary = {
	sd.Season.SPRING: Color(0.55, 0.64, 0.31, 0.25),
	sd.Season.SUMMER: Color(0.82, 0.8, 0.24, 0.25),
	sd.Season.AUTUMN: Color(0.91, 0.55, 0.36, 0.25),
	sd.Season.WINTER: Color(0.43, 0.72, 0.76, 0.25),
	sd.Season.DRAFT: Color(1, 1, 1, 0.5)
}

# Methods
func _ready():
	self.data = sd.SeasonData.new()
	State.state.seasons = self
	var _x
	_x = self.data.connect("update_ui", self, "update_ui")
	self.update_ui(self.data.season, self.data.year)

func _process(delta):
	self.data.update(delta)
	$Progress.value = self.data.season_progress

func update_ui(season, year):
	$YearText.bbcode_text = "[center]YEAR %s[/center]" % year
	$SeasonText.bbcode_text = "[center]%s[/center]" % self.season_names[season]
	var tween = create_tween()
	tween.tween_property(get_tree().current_scene.get_node("Background/Color"), "color", self.season_colors[season], 0.2)

 
