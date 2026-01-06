class_name TacheBase extends CharacterBody2D

var max_speed: float = 80.0
var low_speed: float = 20.0
var	acceleration: float = 10.0
var hit: bool = false
var home: bool = false


@onready var player: CharacterBody2D = null

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var msm: MobStateMachine = $MobStateMachine
@onready var mob_wander_state: TacheWanderState = $MobStateMachine/MobWanderState as TacheWanderState
@onready var mob_chase_state: TacheChaseState = $MobStateMachine/MobChaseState as TacheChaseState
@onready var mob_idle_state: TacheIdleState = $MobStateMachine/MobIdleState as TacheIdleState
@onready var mob_home_state: TacheHomeState = $MobStateMachine/MobHomeState as TacheHomeState

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
