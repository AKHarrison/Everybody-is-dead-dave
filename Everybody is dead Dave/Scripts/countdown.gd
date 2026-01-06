extends Node

@onready var label = $Label

func _ready():
	GlobalTimer.timer.timeout.connect(time_left_to_live)
	GlobalTimer.timer.paused = false
	
func time_left_to_live():
	var time_left = GlobalTimer.timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta: float) -> void:
	label.text = "%02d:%02d" % time_left_to_live()
