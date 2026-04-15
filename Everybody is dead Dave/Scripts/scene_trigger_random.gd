class_name SceneTriggerRandom extends Area2D

var scene_folder = "res://Scenes/Game/"

var levels = [
	"nice_terrace_gauntlet",
	"nice_terrace_gauntlet_flip",
	"ruff_terrace",
	"dreggs",
	]
	

func _on_body_entered(body):
	if body is Player:
		select_level()
		
	
	
func select_level():
	var connected_scene = levels.pick_random()
	scene_manager.change_scene(get_owner(), connected_scene)
