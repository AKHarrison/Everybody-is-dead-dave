extends Node

var car_types = [
	preload("res://Scenes/Mob/green_car_follow.tscn")
	#preload("res://Scenes/Environment/green_car.tscn"),
	#preload("res://Scenes/Environment/red_car.tscn"),
	#preload("res://Scenes/Environment/yellow_car.tscn")
] 

@onready var car_spawn: Marker2D = $CarSpawn



func spawn_car():
	
	var car = car_types.pick_random()
	var new_car = car.instantiate()
	$CarSpawn.progress_ratio = 0
	new_car.global_position = $CarSpawnD.global_position
	add_child(new_car)
	


func _on_timer_timeout():
	spawn_car()
