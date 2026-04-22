class_name SceneTriggerMGD extends Area2D




var utb = "UTB"
var nice_terrace_maze = "NiceTerraceMaze"
var ruff_terrace = "RuffTerrace"


var levels = [
	"nice_terrace_maze",
	"ruff_terrace",
]

func _on_body_entered(body):
	if body is Player:
		if scene_manager.ruffT and scene_manager.niceTM:
			select_dreggs()
			print("dreggs")
		else:
			select_level()

func select_level():
	var _current_scene = get_tree().current_scene.name
	print("Current scene: ", _current_scene)

	if _current_scene == utb:
		var picked = levels.pick_random()
		if picked == "ruff_terrace":
			scene_manager.niceTM = true
		elif picked == "nice_terrace_maze":
			scene_manager.ruffT = true
		print("ruffT: ", scene_manager.ruffT, " niceTM: ", scene_manager.niceTM)
		scene_manager.change_scene(get_tree().current_scene, picked)
		
	elif _current_scene == ruff_terrace:
		scene_manager.ruffT = true
		print("ruffT: ", scene_manager.ruffT, " niceTM: ", scene_manager.niceTM)
		scene_manager.change_scene(get_tree().current_scene, levels[0])
		

	elif _current_scene == nice_terrace_maze:
		scene_manager.niceTM = true
		print("ruffT: ", scene_manager.ruffT, " niceTM: ", scene_manager.niceTM)
		scene_manager.change_scene(get_tree().current_scene, levels[1])
		
	else:
		print("Failed to change scene")


func select_dreggs():
	var connected_scene = "dreggs"
	scene_manager.change_scene(get_tree().current_scene, connected_scene)
		
