extends Node

var mob_types = [
	preload("res://Scenes/Mob/mob_edna.tscn"),
	preload("res://Scenes/Mob/mob_gran.tscn"),
	preload("res://Scenes/Mob/mob_tache.tscn")
] 

@onready var rough_terrace_1: Marker2D = %RoughTerrace1



func spawn_mob():
	var spawn_points = [
	rough_terrace_1,
]
	var spawn_point = spawn_points.pick_random()
	var mob_scene = mob_types.pick_random()
	var new_mob = mob_scene.instantiate()
	new_mob.global_position = spawn_point.global_position
	add_child(new_mob)
	MobManager.total_mobs_spawned += 1
	print("Total mobs spawned: ", MobManager.total_mobs_spawned)

	
func _on_timer_timeout() -> void:
	spawn_mob()

	
