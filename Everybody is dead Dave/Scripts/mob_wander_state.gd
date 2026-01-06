class_name MobWanderState extends MobState

@export var actor: CharacterBody2D	
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer

signal found_player

func _enter_state():
	set_physics_process(true)
	animator.play("tache_idle")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.low_speed
		
		
func _exit_state():
	set_physics_process(false)
	
func _physics_process(delta):
	var wander_velocity = actor.velocity * 0.5
	var collision = actor.move_and_collide(wander_velocity * delta)
	if collision:
		var bounce_velocity = wander_velocity.bounce(collision.get_normal())
		actor.velocity = bounce_velocity
	if not vision_cast.is_colliding():
		found_player.emit()
	
