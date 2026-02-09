extends Node

var current_state: State = null
var states: Dictionary = {}

func _ready():
	# Wait one frame for all states to be ready
	await owner.ready
	
	# Register all child states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(_on_state_transition)
	
	# Start with first state
	if states.size() > 0:
		current_state = states.values()[0]
		current_state.enter()

func _on_state_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	if new_state == null or new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func physics_update(delta: float):
	if current_state:
		current_state.physics_update(delta)
