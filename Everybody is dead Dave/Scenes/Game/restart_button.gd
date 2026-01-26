extends Button

@export var connected_scene: String 
var scene_folder = "res://Scenes/Game/"

func _on_pressed() -> void:

	get_tree().change_scene_to_file("res://Scenes/Game/Main.tscn")
	GlobalTimer.timer.start()
