extends NewMobState

@export var idle_duration: float = 2.0

var timer: float = 0.0

func enter():
	timer = idle_duration
	enemy.velocity = Vector2.ZERO

func physics_update(delta: float):
	timer -= delta
	
	# Check for player
	if enemy.can_see_player():
		state_transition.emit("Chase")
		return
	
	# After idle time, start wandering
	if timer <= 0:
		state_transition.emit("Wander")
