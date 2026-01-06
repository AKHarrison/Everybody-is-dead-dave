class_name GeordieWanderState
extends MobState

@export var detection_range: float = 200.0
@export var actor: CharacterBody2D	
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")



signal found_player

func _enter_state():
	set_physics_process(true)
	if animator:
		animator.play("geordie_move")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.low_speed

func _exit_state():
	set_physics_process(false)

func _physics_process(delta):
	# Normalize direction and apply low_speed
	var move_direction = actor.velocity.normalized()
	actor.velocity = move_direction * actor.low_speed

	# Move and bounce off surfaces
	var collision = actor.move_and_collide(actor.velocity * delta)
	if collision:
		actor.velocity = actor.velocity.bounce(collision.get_normal()).normalized() * actor.low_speed

	# Update raycast toward player
	if player and player.is_inside_tree():
		vision_cast.target_position = player.global_position - actor.global_position
		var distance = actor.global_position.distance_to(player.global_position)
		if distance <= detection_range:
			found_player.emit()
			print("found player")
