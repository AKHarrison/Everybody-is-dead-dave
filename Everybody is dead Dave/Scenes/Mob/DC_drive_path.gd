extends PathFollow2D

var speed := 0.1
@export var sprite = Sprite2D

func _process(delta: float) -> void:
	loop_movement(delta)
	
func flip_sprite():
	sprite.flip_v = true

	
func loop_movement(delta):
	progress_ratio += delta * speed
