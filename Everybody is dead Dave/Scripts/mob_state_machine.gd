class_name MobStateMachine extends Node

@export var state: MobState



func _ready():
	change_state(state)
	
func change_state(new_state: MobState):
	if state is MobState:
		state._exit_state()
	new_state._enter_state()
	state = new_state
	
