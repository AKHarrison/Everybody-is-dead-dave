extends NewMobState

@export var wander_radius: float = 100.0
@export var wander_duration: float = 3.0

var wander_target: Vector2
var timer: float = 0.0

func enter():
	enemy.move_speed = enemy.wander_speed
	pick_new_wander_point()

func pick_new_wander_point():
	var random_offset = Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius, wander_radius)
	)
	wander_target = enemy.global_position + random_offset
	timer = wander_duration

func physics_update(delta: float):
	timer -= delta
	
	# Check for player
	if enemy.can_see_player():
		state_transition.emit("Chase")
		return
	
	# Move toward wander point
	enemy.move_to_target(wander_target)
	
	# Pick new point or go idle
	if timer <= 0 or enemy.navigation_agent.is_navigation_finished():
		if randf() > 0.5:
			state_transition.emit("Idle")
		else:
			pick_new_wander_point()
