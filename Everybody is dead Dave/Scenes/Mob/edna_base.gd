class_name EdnaBase extends CharacterBody2D

var max_speed: float = 90.0
var low_speed: float = 20.0
var	acceleration: float = 10.0
var hit: bool = false
var home: bool = false


@onready var player: CharacterBody2D = null

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var msm: MobStateMachine = $MobStateMachine
@onready var mob_wander_state: EdnaWanderState = $MobStateMachine/MobWanderState as EdnaWanderState
@onready var mob_chase_state: EdnaChaseState = $MobStateMachine/MobChaseState as EdnaChaseState
@onready var mob_idle_state: EdnaIdleState = $MobStateMachine/MobIdleState as EdnaIdleState
@onready var mob_home_state: EdnaHomeState = $MobStateMachine/MobHomeState as EdnaHomeState

func _ready():
	player = get_tree().get_first_node_in_group("player")
	mob_wander_state.found_player.connect(msm.change_state.bind(mob_chase_state))
	mob_chase_state.lost_player.connect(msm.change_state.bind(mob_wander_state))
	mob_chase_state.insult_hit.connect(msm.change_state.bind(mob_idle_state))
	
func set_idle():
	hit = true
	
func send_home():
	home = true

		
func _physics_process(delta):
	if is_instance_valid(player) and player.is_inside_tree():
		ray_cast_2d.target_position = ray_cast_2d.to_local(player.global_position)
