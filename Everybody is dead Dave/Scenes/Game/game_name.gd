extends CanvasLayer

func _ready():
	# Start off-screen at the top
	offset.y = -get_viewport().get_visible_rect().size.y
	delayed_slide_in(2.5)

func delayed_slide_in(delay: float):
	var tween = create_tween()
	tween.tween_interval(delay)
	tween.tween_property(self, "offset:y", 0.0, 1.0).set_ease(Tween.EASE_OUT)
	
