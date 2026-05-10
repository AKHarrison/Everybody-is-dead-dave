class_name Car extends CharacterBody2D

var direction := Vector2.LEFT
var speed := 300.0
var despawn_min := -101.0
var despawn_max := 1300.0

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()
	
	if global_position.x < despawn_min or global_position.x > despawn_max:
		queue_free()
