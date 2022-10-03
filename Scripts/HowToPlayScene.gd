extends Node2D

var index: int = 0

var text: Array = [
	"The objective of the game is to survive 10 years without all your population dying.\n\nEach year consists of [b]4 seasons[/b], each taking 10 seconds of real time: spring, summer, autumn and winter. You can always check the current season and year at the top right corner of the screen.",
	"You can check your current resources at the top left corner of the screen. In order, those are: [b]population[/b], [b]food[/b], [b]wood[/b] and [b]gold[/b].\n\nIf your population reaches zero, [b]you lose the game[/b].\n\nIf your food reaches zero, [b]your population will start decreasing[/b].\n\nWood is used to build in the center area of the board.\n\nGold is used as a trade resource and for buying new cards on the market.",
	"On the bottom of the screen you can see your deck, hand and discard pile.\n\nYou can also your [b]current and max hand size[/b], and your [b]current and max action points here[/b].\n\nTo play a card, simply drag it to the center of the board.\n\nThere are two types of cards: [b]buildings[/b] and [b]actions[/b].",
	"On the middle of the board, you can see slots for playing your [b]building cards[/b].\n\nTo play a building, simply drag it from your hand and drop it on an empty slot on the field. You can see the [b]wood cost[/b] on the top  of the card.If you don't have enough wood, you can't play the building.\n\nSome buildings have [b]activated abilities[/b]. To activate them, [b]click on the card[/b].\nAfter that, the building will enter a cooldown period where you can't click again.",
	"[b]Action cards[/b] are played from your hand, have an immediate effect, then go to your graveyard.\n\nTo play an action card, drag it from your hand into anywhere in the board. You will have to spend [b]action points[/b] to play it. If you don't have enough, you can't play the action.\n\n[b]Action points are shown next to your deck, and are refreshed at the start of each season.[/b]\n\n[b]You can click on your deck to spend an action point to draw a card anytime.[/b]",
	"At the [b]end of the year[/b], there will be a [b]shopping period[/b].\n\nHere, you can spend your [b]gold[/b] to add new cards to your deck.\n\nCards purchased this way go to your discard pile, and will be reshuffled into your deck next time it's empty."
]
var titles: Array = [
	"Welcome!",
	"Resources",
	"Deck, hand and discard",
	"Buildings",
	"Actions",
	"Shopping phase"
]
var images: Array = [
	load("res://RawResources/Graphics/explanation1.png"),
	load("res://RawResources/Graphics/explanation2.png"),
	load("res://RawResources/Graphics/explanation3.png"),
	load("res://RawResources/Graphics/explanation4.png"),
	load("res://RawResources/Graphics/explanation5.png"),
	load("res://RawResources/Graphics/explanation6.png")
]


func _ready():
	$ExplanationText.bbcode_text = self.text[self.index]
	$TitleText.bbcode_text = self.titles[self.index]

func _on_BackBtn_pressed():
	Sound.sound.play_effect("ui_click")	
	get_tree().change_scene("res://Scenes/MainMenuScene.tscn")


func _on_BackBtn_mouse_entered():
	Sound.sound.play_effect("hover")	


func _on_NextBtn_pressed():
	if self.index < len(self.titles) - 1:
		Sound.sound.play_effect("ui_click")	
		self.index += 1
		$ExplanationText.bbcode_text = self.text[self.index]
		$TitleText.bbcode_text = self.titles[self.index]
		$ExplanationImage.texture = self.images[self.index]
	if self.index == len(self.titles):
		$NextBtn.disabled = true


func _on_NextBtn_mouse_entered():
	Sound.sound.play_effect("hover")	
