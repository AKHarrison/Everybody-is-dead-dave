extends Node2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var time_2: Label = $CanvasLayer/Time2
@onready var saved_2: Label = $CanvasLayer/Saved2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.play()
	GlobalTimer.timer.paused = true
	time_alive()
	mobs_killed()
	save_run_to_leaderboard()
	
func time_alive():
	GlobalTimer.stop_timer()
	time_2.text = GlobalTimer.get_formatted_time()
	print("Survived for: ", GlobalTimer.get_formatted_time())
	
func mobs_killed():
	var mobs_killed2 = MobManager.total_mobs_spawned
	saved_2.text = str(mobs_killed2)
	
func save_run_to_leaderboard():
	var time_survived = GlobalTimer.get_formatted_time()
	var mobs_killed1 = MobManager.total_mobs_spawned
	WinManager.add_leaderboard_entry(time_survived, mobs_killed1)
