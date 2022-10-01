extends ColorRect

var hovering: bool = false

func _process(_delta):
	self.hovering = self.is_mouse_hovering()
	if self.hovering:
		self.modulate.a = 0.5
	else:
		self.modulate.a = 0.0

func is_mouse_hovering():
	return [
		(get_global_mouse_position().x - self.rect_position.x) < self.rect_size.x,
		(get_global_mouse_position().y - self.rect_position.y) < self.rect_size.y,
		(get_global_mouse_position().x - self.rect_position.x) > 0,
		(get_global_mouse_position().y - self.rect_position.y) > 0
	].count(true) == 4
	
