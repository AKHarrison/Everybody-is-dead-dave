class_name EdnaWanderState2 extends MobState

@export var detection_range: float = 200.0
@export var actor: CharacterBody2D	
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer

signal found_player

func _enter_state():
	set_physics_process(true)
	animator.play("edna_idle")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.low_speed
		
		
func _exit_state():
	set_physics_process(false)
	
func _physics_process(delta):
	var wander_velocity = actor.velocity * 1
	var collision = actor.move_and_collide(wander_velocity * delta)
	if collision:
		var bounce_velocity = wander_velocity.bounce(collision.get_normal())
		actor.velocity = bounce_velocity

	# Aim the ray toward the player's last known direction (optional, or fixed forward)
	vision_cast.force_raycast_update()
	
	if vision_cast.is_colliding() and actor.hit != true:
		var collider = vision_cast.get_collider()
		if collider and collider.is_in_group("player"):
			var distance = actor.global_position.distance_to(collider.global_position)
			if distance <= detection_range:
				found_player.emit()
