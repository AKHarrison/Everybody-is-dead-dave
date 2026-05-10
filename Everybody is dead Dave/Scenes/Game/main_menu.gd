extends Control

@onready var music: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	music.play()
	var hud = get_node("/root/HudManager")  # however you access your UI layer
	hud.hide_hud()

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/start_screen.tscn")

	

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/utb.tscn")
	GlobalTimer.timer.start()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
