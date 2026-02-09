class_name EdnaIdleState extends MobState

@export var actor: CharacterBody2D	
@onready var animator: AnimationPlayer = %AnimationPlayer
@onready var mob_home_state: EdnaHomeState = $"../MobHomeState"
@onready var mob_state_machine: MobStateMachine = $".."

signal go_home

	

func _enter_state():
	set_physics_process(true)
	animator.play("edna_idle")
	actor.velocity = Vector2.ZERO
	
func _exit_state():
	set_physics_process(false)

func home():
	if actor.home == true and actor.hit == true:
		mob_state_machine.change_state(mob_home_state)
		

		
		
func _process(delta):
	home()
