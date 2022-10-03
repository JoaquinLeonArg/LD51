extends Node2D

# Constants


# Imports
const sd = preload("res://Scripts/Classes/SeasonData.gd")
const game_over_scene = preload("res://Components/GameOver.tscn")

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
	sd.Season.DRAFT: Color(0, 0, 0, 0.5)
}
var season_icons: Dictionary = {
	sd.Season.SPRING: load("res://RawResources/Graphics/spring.png"),
	sd.Season.SUMMER: load("res://RawResources/Graphics/summer.png"),
	sd.Season.AUTUMN: load("res://RawResources/Graphics/fall.png"),
	sd.Season.WINTER: load("res://RawResources/Graphics/winter.png"),
	sd.Season.DRAFT: load("res://RawResources/Graphics/coin_ico.png")
}
var season_effects: Dictionary = {
	sd.Season.SPRING: "[b][center]Season effects[/center][/b]\n\n * Increased food production by 100%.",
	sd.Season.SUMMER: "[b][center]Season effects[/center][/b]\n\n * Increased food production by 50%.\n * Draw 1 extra card.",
	sd.Season.AUTUMN: "[b][center]Season effects[/center][/b]\n\n * Increased wood production by 50%.",
	sd.Season.WINTER: "[b][center]Season effects[/center][/b]\n\n * Decreased food production by 50%%.\n * Increased food maintenance by 3.\n * Increased food maintenance\n   permanently by %s." % (State.state.difficulty + 1),
	sd.Season.DRAFT: "[b][center]Season effects[/center][/b]"
}

# Methods
func _ready():
	self.data = sd.SeasonData.new()
	State.state.seasons = self
	var _x
	_x = self.data.connect("update_ui", self, "update_ui")
	_x = self.data.connect("win", self, "win")
	self.update_ui(self.data.season, self.data.year)

func _process(delta):
	self.data.update(delta)
	$Progress.value = self.data.season_progress

func update_ui(season, year):
	$YearText.bbcode_text = "[center]YEAR %s[/center]" % year
	$SeasonText.bbcode_text = "[center]%s[/center]" % self.season_names[season]
	$Sprite.texture = self.season_icons[season]
	$Effects/EffectsText.bbcode_text = self.season_effects[season]
	var tween = create_tween()
	tween.tween_property(get_tree().current_scene.get_node("Background/Color"), "color", self.season_colors[season], 0.2)


func win():
	State.state.paused = true
	var win_screen = game_over_scene.instance()
	win_screen.get_node("GameOverTitle").bbcode_text = "[center]YOU WIN[/center]"
	win_screen.get_node("GameOverMsg").bbcode_text = "[center]You survived 10 years![/center]"
	get_tree().current_scene.add_child(win_screen) 
