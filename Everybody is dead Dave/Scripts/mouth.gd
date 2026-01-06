extends Area2D

@onready var sorry_audio: AudioStreamPlayer2D = $Audio/Sorry_audio

var insults = [
	preload("res://Scenes/Player/Insults/Twat.tscn"),
	preload("res://Scenes/Player/Insults/numpty.tscn"),
	preload("res://Scenes/Player/Insults/divvy.tscn"),
	]
	
var sorry = preload("res://Scenes/Player/Insults/Sorry.tscn")

#var numpty = preload("res://Scenes/insult3.tscn") 
var current_ammo_index = 0
var current_insult_index = 0

const AMMO_DAMAGE = 0.5
const INSULT_DAMAGE = 0.1

func _input(event):
	if event.is_action_pressed("ui_A"):
		insult_twat()

	elif event.is_action_pressed("sorry"):
		print("bob")
		say_sorry()

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var closest = get_closest_target(enemies_in_range, global_position)
		if closest:
			look_at(closest.global_position)
			var angle_to_target = (closest.global_position - global_position).angle()
			rotation = lerp_angle(rotation, angle_to_target, delta * 5)

func insult_twat():
	var insult_scene = insults.pick_random()
	var new_insult = insult_scene.instantiate()
	new_insult.global_position = %AttackPoint.global_position
	new_insult.global_rotation = %AttackPoint.global_rotation
	%AttackPoint.add_child(new_insult)
	
	
func say_sorry():
	var insult_scene = sorry
	var new_insult = insult_scene.instantiate()
	new_insult.global_position = %AttackPoint.global_position
	new_insult.global_rotation = %AttackPoint.global_rotation
	%AttackPoint.add_child(new_insult)
	sorry_audio.pitch_scale = randf_range(0.9, 1.1)
	sorry_audio.play()
	
func get_closest_target(targets: Array, origin: Vector2) -> Node:
	var closest_target: Node = null
	var shortest_distance := INF

	for target in targets:
		if not target.has_method("get_global_position"):  # Ensure it's valid
			continue
		var dist = origin.distance_to(target.global_position)
		if dist < shortest_distance:
			shortest_distance = dist
			closest_target = target

	return closest_target
