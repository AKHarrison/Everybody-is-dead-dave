extends CanvasLayer

@onready var label = $Label
@onready var audio: AudioStreamPlayer2D = $audio/AudioStreamPlayer2D
var last_beep_time := 0  # in milliseconds

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
	beep()
	
func beep():
	if not GlobalTimer.timer.paused:
		var now = Time.get_ticks_msec()
		if now - last_beep_time >= 1000:
			audio.play()
			last_beep_time = now
