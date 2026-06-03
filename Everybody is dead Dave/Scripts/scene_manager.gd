class_name SceneManager extends Node

var player: Player
var scene_dir_path = "res://Scenes/Game/"
var current_scene: Node
var ruffT = false
var niceTM = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene(from, to_scene_name: String) -> void:
	var tree = get_tree()
	var full_path = scene_dir_path + to_scene_name + ".tscn"

	animation_player.play("fade_out")
	await animation_player.animation_finished

	# Remove player only once screen is black
	player = from.player
	player.get_parent().remove_child(player)

	tree.call_deferred("change_scene_to_file", full_path)

	await tree.process_frame
	await tree.process_frame

	animation_player.play("fade_in")
