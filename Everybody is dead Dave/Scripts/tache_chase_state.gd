class_name TacheChaseState extends MobState


@export var actor: CharacterBody2D
@export var vision_cast: RayCast2D
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var player: CharacterBody2D = null
@onready var navigation_agent: NavigationAgent2D = $"../../NavigationAgent2D"

signal lost_player
signal insult_hit

var player_was_visible := true
var was_hit := false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	set_physics_process(false)
	
func player_lost():
	if vision_cast.is_colliding():
		lost_player.emit()

		
	if actor.hit == true:
		insult_hit.emit()

	
func _enter_state() -> void:
	set_physics_process(true)
	#animator.play("gran_move")
	
func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(_delta) -> void:
	if is_instance_valid(player) and player.is_inside_tree():
		navigation_agent.target_position = player.global_position
		var next_position = navigation_agent.get_next_path_position()
		var direction = actor.global_position.direction_to(next_position)

		actor.velocity = direction * actor.max_speed
		actor.move_and_slide()
		player_lost()
