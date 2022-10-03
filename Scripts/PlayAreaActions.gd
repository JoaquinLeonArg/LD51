extends ColorRect

# Imports
const cd = preload("res://Scripts/Classes/CardData.gd")

var hovering: bool = false

func _process(_delta):
	self.hovering = self.is_mouse_hovering()

func _input(event):
	if not self.hovering:
		return
	if event.is_action_released("left_click"):
		var card = State.state.current_card
		if card and card.data.type == cd.CardType.ACTION and card.data.can_be_played():
			State.state.current_card = null
			card.dragging = false
			card.data.play_as_action()

			State.state.hand.remove_card(card)
			State.state.discard.add_card(card)

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.rect_position.x - 960) <= self.rect_size.x,
		(get_global_mouse_position().y - self.rect_position.y - 100) <= self.rect_size.y,
		(get_global_mouse_position().x - self.rect_position.x - 960) >= 0,
		(get_global_mouse_position().y - self.rect_position.y - 100) >= 0
	].count(true) == 4
	
