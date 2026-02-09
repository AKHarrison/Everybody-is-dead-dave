extends CharacterBody2D

@export var move_speed: float = 50.0
@export var wander_speed: float = 30.0
@export var chase_speed: float = 80.0
@export var detection_range: float = 150.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var state_machine: Node = $StateMachine

var player: CharacterBody2D = null

func _ready():
	# Find player in scene
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	state_machine.physics_update(delta)

func can_see_player() -> bool:
	if not player:
		return false
	
	# Point raycast toward player
	player_detector.target_position = to_local(player.global_position)
	player_detector.force_raycast_update()
	
	# Check if player is in range and raycast hits them
	var distance = global_position.distance_to(player.global_position)
	return distance <= detection_range and player_detector.is_colliding() and player_detector.get_collider() == player

func move_to_target(target_position: Vector2):
	navigation_agent.target_position = target_position
	
	if navigation_agent.is_navigation_finished():
		return
	
	var next_position = navigation_agent.get_next_path_position()
	var direction = (next_position - global_position).normalized()
	
	velocity = direction * move_speed
	move_and_slide()
