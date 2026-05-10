extends CanvasLayer

func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func _can_pause() -> bool:
	var scene = get_tree().current_scene
	if scene == null:
		return false
	return scene.scene_file_path != "res://Scenes/Game/main_menu.tscn"

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") and _can_pause():
		toggle_pause()
		
func toggle_pause():
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	visible = is_paused

func _on_resume_pressed() -> void:
	toggle_pause()



func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game/main_menu.tscn")
	
