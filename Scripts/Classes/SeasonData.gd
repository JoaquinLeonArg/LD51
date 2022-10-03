enum Season { SPRING, SUMMER, AUTUMN, WINTER, DRAFT } # SPRING = 0, SUMMER = 1, AUTUMN = 2, WINTER = 3


class SeasonData:
	const rd = preload("res://Scripts/Classes/ResourceData.gd")
	const content_behaviors = preload("res://Scripts/Content/Behaviors.gd")

	var year: int = 0
	var season: int = Season.WINTER
	var season_progress: float = 0
	var season_behaviors: Dictionary = {
		Season.SPRING: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.FOOD, 1.0)
		],
		Season.SUMMER: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.FOOD, 0.5),
			content_behaviors.ChangeExtraResourceBehavior.new(rd.ExtraResourceType.DRAW_SIZE, 1)
		],
		Season.AUTUMN: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.WOOD, 0.5)
		],
		Season.WINTER: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.WOOD, 0.5),
			content_behaviors.ChangeMaintenanceBehavior.new(rd.ResourceType.FOOD, 3),
			content_behaviors.ChangeMaintenanceBehavior.new(rd.ResourceType.FOOD, State.state.difficulty + 1, true)
		],
		Season.DRAFT: []
	}

	signal update_ui(season, year)
	signal win

	func stop_music(current_season: int):
		match current_season:
			Season.SPRING:
				Sound.sound.stop_music("main_menu")
			Season.SUMMER:
				Sound.sound.stop_music("spring")
			Season.AUTUMN:
				Sound.sound.stop_music("summer")
			Season.WINTER:
				Sound.sound.stop_music("autumn")
			Season.DRAFT:
				Sound.sound.stop_music("winter")

	func play_music(current_season: int):
		match current_season:
			Season.SPRING:
				Sound.sound.play_music("spring")
			Season.SUMMER:
				Sound.sound.play_music("summer")
			Season.AUTUMN:
				Sound.sound.play_music("autumn")
			Season.WINTER:
				Sound.sound.play_music("winter")
			Season.DRAFT:
				Sound.sound.play_music("main_menu")

	func update(delta):
		if State.state.paused:
			return
		self.season_progress += delta
		if self.season_progress >= 10:
			self.season_progress -= 10
			if self.season != Season.DRAFT:
				State.state.resources.data.replenish_ap()
				State.state.field.season_end()
			for behavior in self.season_behaviors[self.season]:
				behavior.on_destroy()
			self.season = (self.season + 1) % 5
			stop_music(self.season)
			play_music(self.season)
			for behavior in self.season_behaviors[self.season]:
				behavior.on_play()
			State.state.deck.data.draw(State.state.resources.data.extra_resources[rd.ExtraResourceType.DRAW_SIZE])
			if self.season == Season.DRAFT:
				print("Draft time")
				State.state.paused = true
				State.state.shop.show()
			if self.season == Season.SPRING:
				State.state.shop.close()
				self.year += 1
				State.state.field.year_end()
				if self.year == 10:
					emit_signal("win")
			emit_signal("update_ui", self.season, self.year)
