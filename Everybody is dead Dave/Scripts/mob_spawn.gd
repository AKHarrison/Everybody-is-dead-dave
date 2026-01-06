extends Node

var mob_types = [
	preload("res://Scenes/Mob/mob_edna.tscn"),
	preload("res://Scenes/Mob/mob_gran.tscn"),
	preload("res://Scenes/Mob/mob_tache.tscn")
] 
@onready var west: Marker2D = %West
@onready var dreggs: Marker2D = %Dreggs
@onready var shop_1: Marker2D = %Shop1
@onready var shop_2: Marker2D = %Shop2
@onready var shop_3: Marker2D = %Shop3
@onready var rough_terrace_2: Marker2D = %RoughTerrace2
@onready var rough_terrace_4: Marker2D = %RoughTerrace4
@onready var rough_terrace_3: Marker2D = %RoughTerrace3
@onready var rough_terrace_1: Marker2D = %RoughTerrace1
@onready var nice_terrace_1: Marker2D = %NiceTerrace1
@onready var nice_terrace_4: Marker2D = %NiceTerrace4
@onready var nice_terrace_2: Marker2D = %NiceTerrace2
@onready var nice_terrace_3: Marker2D = %NiceTerrace3


func spawn_mob():
	var spawn_points = [
	dreggs, shop_1, shop_2, shop_3, rough_terrace_1, rough_terrace_2, rough_terrace_3, rough_terrace_4, nice_terrace_2, nice_terrace_3, nice_terrace_4 
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

	
