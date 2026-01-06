class_name NewSceneManager  extends Node

var player: Player
var scene_dir_path = "res://Scenes/Game/"
var current_scene: Node = null  # Store the current scene for re-use

func change_scene(from: Node, to_scene_name: String) -> void:
	# Save the current scene root if not already
	if current_scene == null:
		current_scene = from
	
	# Detach the player (or any persistent nodes)
	player = from.get_node("Player")  # or however your player is accessed
	from.remove_child(player)
	
	# Remove current scene from scene tree but keep in memory
	from.get_tree().get_root().remove_child(from)
	
	# Load and instance the new scene
	var new_scene_path = scene_dir_path + to_scene_name + ".tscn"
	var new_scene = load(new_scene_path).instantiate()
	
	# Add new scene and reattach persistent nodes if needed
	from.get_tree().get_root().add_child(new_scene)
	new_scene.add_child(player)  # Optional
	
	# Update current_scene reference
	current_scene = new_scene
