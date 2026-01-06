extends Node2D
@onready var explosion: AudioStreamPlayer2D = $audio/AudioStreamPlayer2D
@onready var theme: AudioStreamPlayer2D = $audio/AudioStreamPlayer2D2
@onready var label_alive: Label = $Node2D/TimeAlive
@onready var mobs: Label = $Node2D/Mobs



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	explosion.play()
	theme.play()
	GlobalTimer.timer.paused = true
	time_alive()
	display_mobs_killed()
	save_run_to_leaderboard()
	
func time_alive():
	GlobalTimer.stop_timer()
	label_alive.text = GlobalTimer.get_formatted_time()
	print("Survived for: ", GlobalTimer.get_formatted_time())
	
func display_mobs_killed():
	var mobs_killed = MobManager.total_mobs_spawned
	mobs.text = str(mobs_killed)
	print("Mobs killed: ", mobs_killed)

func save_run_to_leaderboard():
	var time_survived = GlobalTimer.get_formatted_time()
	var mobs_killed = MobManager.total_mobs_spawned
	MobManager.add_leaderboard_entry(time_survived, mobs_killed)
