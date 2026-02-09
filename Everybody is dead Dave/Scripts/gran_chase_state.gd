class_name GranChaseState extends MobState

@export var actor: CharacterBody2D
@export var lost_player_time: float = 2.0  # Seconds before giving up
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var player: CharacterBody2D = null
@onready var navigation_agent: NavigationAgent2D = $"../../NavigationAgent2D"

signal lost_player
signal insult_hit

var time_since_seen: float = 0.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	time_since_seen = 0.0  # Reset timer when starting chase
	if animator:
		animator.speed_scale = 1.0
		animator.play("gran_move")

func _exit_state() -> void:
	set_physics_process(false)
	if animator:
		animator.stop()

func _physics_process(delta) -> void:
	# Priority check: if hit by insult, stop chasing immediately
	if actor.hit:
		insult_hit.emit()
		return
	
	# Validate player still exists
	if not is_instance_valid(player) or not player.is_inside_tree():
		lost_player.emit()
		return
	
	# Navigate toward player
	navigation_agent.target_position = player.global_position
	
	if not navigation_agent.is_navigation_finished():
		var next_position = navigation_agent.get_next_path_position()
		var direction = actor.global_position.direction_to(next_position)
		actor.velocity = direction * actor.max_speed
		actor.move_and_slide()
	
	# Check vision with grace period
	check_player_visibility(delta)

func check_player_visibility(delta: float) -> void:
	# Can we see the player right now?
	if actor.can_see_player():
		time_since_seen = 0.0  # Reset counter - we have visual
	else:
		# Lost visual - start counting
		time_since_seen += delta
		
		# Give up after grace period
		if time_since_seen >= lost_player_time:
			lost_player.emit()
