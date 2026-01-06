extends CharacterBody2D

@onready var player: CharacterBody2D = null

var special_health = 1
var health = 3 
  # Reference to the Flurp2D sprite
#@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
#@onready var start: PathFollow2D = %Start



const SPEED = 30.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)
	call_deferred("wait_for_physics")
	move()
	
	
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)
	
func move():
	%AnimationPlayer.play("edna_move")
	
	
#func mob_target():
	#target_position = target_to_chase.global_position
	#velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
	#move_and_slide()
	
	
func _physics_process(delta: float) -> void:
	#mob_target()
	var distance = global_position.direction_to(player.global_position)

	velocity = distance * 50.00
	move_and_slide()
