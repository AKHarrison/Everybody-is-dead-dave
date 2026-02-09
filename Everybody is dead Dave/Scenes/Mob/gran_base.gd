class_name GranBase extends CharacterBody2D

var max_speed: float = 70.0
var low_speed: float = 20
var	acceleration: float = 5.0
var hit: bool = false
var home: bool = false


@onready var player: CharacterBody2D = null

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var msm: MobStateMachine = $MobStateMachine
@onready var mob_wander_state: GranWanderState = $MobStateMachine/MobWanderState as GranWanderState
@onready var mob_chase_state: GranChaseState = $MobStateMachine/MobChaseState as GranChaseState
@onready var mob_idle_state: GranIdleState = $MobStateMachine/MobIdleState as GranIdleState
@onready var mob_home_state: GranHomeState = $MobStateMachine/MobHomeState as GranHomeState

func _ready():
	player = get_tree().get_first_node_in_group("player")
	mob_wander_state.found_player.connect(msm.change_state.bind(mob_chase_state))
	mob_chase_state.lost_player.connect(msm.change_state.bind(mob_wander_state))
	mob_chase_state.insult_hit.connect(msm.change_state.bind(mob_idle_state))
	
func set_idle():
	hit = true
	
func send_home():
	home = true

func can_see_player() -> bool:
	if not is_instance_valid(player) or not player.is_inside_tree():
		return false
	
	# Update raycast to point at player (relative position)
	ray_cast_2d.target_position = to_local(player.global_position)
	ray_cast_2d.force_raycast_update()
	
	# Check if raycast hits the player specifically
	return ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player
		
func _physics_process(delta):
	if is_instance_valid(player) and player.is_inside_tree():
		ray_cast_2d.target_position = ray_cast_2d.to_local(player.global_position)
