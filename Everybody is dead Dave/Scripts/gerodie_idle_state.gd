class_name GeordieIdleState extends MobState

@export var actor: CharacterBody2D	
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var mob_state_machine: MobStateMachine = $".."
@onready var mob_home_state: GeordieHomeState = $"../MobHomeState"

signal go_home

	

func _enter_state():
	set_physics_process(true)
	animator.play("geordie_move")
	actor.velocity = Vector2.ZERO
	
	
func home():
	if actor.home == true and actor.hit == true:

		mob_state_machine.change_state(mob_home_state)
		

		
		
func _process(delta):
	home()
