class_name MobChaseState extends MobState

@export var actor: CharacterBody2D
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var player: CharacterBody2D = null

signal lost_player
signal insult_hit

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)
	
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("tache_move")
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta) -> void:
	if is_instance_valid(player) and player.is_inside_tree():
		var direction = actor.global_position.direction_to(player.global_position)

		actor.velocity = direction * 50.00
		actor.move_and_slide()
		if vision_cast.is_colliding():
			lost_player.emit()
		elif  actor.hit == true:
			insult_hit.emit()

	
