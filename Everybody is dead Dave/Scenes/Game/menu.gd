extends VBoxContainer

func _ready():
	modulate.a = 0.0
	start_delayed_fade(3.0, 1.5)  # Wait 3 seconds, fade over 1.5 seconds

func start_delayed_fade(delay: float, fade_duration: float):
	var tween = create_tween()
	tween.tween_interval(delay)
	tween.tween_property(self, "modulate:a", 1.0, fade_duration).set_ease(Tween.EASE_IN_OUT)
