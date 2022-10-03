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
			content_behaviors.ChangeExtraResourceBehavior.new(rd.ExtraResourceType.DRAW_TIME, -0.5)
		],
		Season.AUTUMN: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.WOOD, 0.5)
		],
		Season.WINTER: [
			content_behaviors.ChangeModifierBehavior.new(rd.ResourceType.WOOD, 0.5),
			content_behaviors.ChangeMaintenanceBehavior.new(rd.ResourceType.PEOPLE, 3)
		],
		Season.DRAFT: []
	}

	signal update_ui(season, year)

	func update(delta):
		if State.state.paused:
			return
		self.season_progress += delta
		if self.season_progress >= 10:
			self.season_progress -= 10
			if self.season != Season.DRAFT:
				State.state.resources.data.replenish_ap()
				State.state.deck.data.draw(State.state.resources.data.extra_resources[rd.ExtraResourceType.DRAW_SIZE])
			for behavior in self.season_behaviors[self.season]:
				behavior.on_destroy()
			self.season = (self.season + 1) % 5
			for behavior in self.season_behaviors[self.season]:
				behavior.on_play()
			
			if self.season == Season.DRAFT:
				print("Draft time")
				State.state.paused = true
				State.state.shop.show()
			if self.season == Season.SPRING:
				State.state.shop.close()
				self.year += 1
				if self.year == 10:
					pass
					# TODO
					# ! trigger endgame event
			emit_signal("update_ui", self.season, self.year)
