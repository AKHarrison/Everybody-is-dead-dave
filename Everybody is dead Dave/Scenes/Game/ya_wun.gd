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
	
func time_alive():
	GlobalTimer.stop_timer()
	time_2.text = GlobalTimer.get_formatted_time()
	print("Survived for: ", GlobalTimer.get_formatted_time())
	
func mobs_killed():
	var mobs_killed = MobManager.total_mobs_spawned
	saved_2.text = str(mobs_killed)
