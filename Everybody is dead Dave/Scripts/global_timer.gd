extends Node

var timer = Timer.new()
var elapsed_time: float = 0.0
var is_timing: bool = false



func _ready() -> void:
	start_timer()
	add_child(timer)
	timer.start(30)
	timer.paused = true
func _process(delta: float):
	if is_timing:
		elapsed_time += delta

func start_timer():
	is_timing = true
	elapsed_time = 0.0

func stop_timer():
	is_timing = false

func pause_timer():
	is_timing = false

func resume_timer():
	is_timing = true

func reset_timer():
	elapsed_time = 0.0

func get_time() -> float:
	return elapsed_time

func get_formatted_time() -> String:
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	var milliseconds = int((elapsed_time - int(elapsed_time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds] 
