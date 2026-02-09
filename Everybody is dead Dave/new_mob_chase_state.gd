extends NewMobState

@export var lost_player_time: float = 2.0

var time_since_seen: float = 0.0

func enter():
	enemy.move_speed = enemy.chase_speed
	time_since_seen = 0.0

func physics_update(delta: float):
	if enemy.can_see_player():
		# Chase the player
		time_since_seen = 0.0
		enemy.move_to_target(enemy.player.global_position)
	else:
		# Lost sight of player
		time_since_seen += delta
		
		if time_since_seen >= lost_player_time:
			state_transition.emit("Idle")
