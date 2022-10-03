extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var effects = null
var music = null

func _ready():
	Sound.sound = self
	effects = {
		"building": $SoundEffectBuilding,
		"cash_register": $SoundEffectCashRegister,
		"card_click": $SoundEffectCardClick,
		"discard_card": $SoundEffectDiscardCard,
		"draw_card_btn": $SoundEffectDrawCardBtn,
		"gather_wood": $SoundEffectGatherWood,
		"heavy_snow": $SoundEffectHeavySnow,
		"hover": $SoundEffectHover,
		"people_screaming": $SoundEffectPeopleScreaming,
		"ui_click": $SoundEffectUiClick,
		"use_card": $SoundEffectUseCard,
	}

	music = {
		"main_menu": $MusicMainMenu,
		"autumn": $MusicAutumn,
		"spring": $MusicSpring,
		"summer": $MusicSummer,
		"winter": $MusicWinter,
	}

func play_effect(effect):
	print("[DEBUG] Playing sound effect: " + effect)
	effects.get(effect).play()

func play_music(music):
	music.get(music).play()
