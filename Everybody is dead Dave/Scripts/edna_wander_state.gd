class_name EdnaWanderState extends MobState


@export var detection_range: float = 200.0
@export var actor: CharacterBody2D	
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")



signal found_player

func _enter_state():
	set_physics_process(true)
	if animator:
		animator.play("edna_idle")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * actor.low_speed

func _exit_state():
	set_physics_process(false)
	if animator:
		animator.stop()

func _physics_process(delta):
	var move_direction = actor.velocity.normalized()
	actor.velocity = move_direction * actor.low_speed
	var collision = actor.move_and_collide(actor.velocity * delta)
	if collision:
		actor.velocity = actor.velocity.bounce(collision.get_normal()).normalized() * actor.low_speed

	if not is_instance_valid(player) or not player.is_inside_tree():
		player = get_tree().get_first_node_in_group("player")
		return

	vision_cast.target_position = player.global_position - actor.global_position
	if actor.global_position.distance_to(player.global_position) <= detection_range:
		found_player.emit()
