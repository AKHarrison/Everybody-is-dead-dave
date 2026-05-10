extends CharacterBody2D

var direction := Vector2.LEFT
var map_limit := 0

func _physics_process(delta):
	velocity = direction * 500
	move_and_slide()
	
	# Despawn once far enough off the left edge
	if global_position.x > map_limit:
		queue_free()
