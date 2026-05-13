extends Node2D

const CAR_TYPES = [
	preload("res://Scenes/Mob/blue_car_slow.tscn"),
	preload("res://Scenes/Mob/green_car_slow.tscn"),
	preload("res://Scenes/Mob/yellow_car_slow.tscn"),
	preload("res://Scenes/Mob/red_car_slow.tscn")
]
	

func spawn_car(spawn_point: Marker2D, car_pool: Array, delay: float, velocity: float, direction: Vector2 = Vector2.LEFT):
	await get_tree().create_timer(delay).timeout
	var new_car = car_pool.pick_random().instantiate()
	new_car.global_position = spawn_point.global_position
	new_car.direction = direction
	new_car.speed = velocity
	add_child(new_car)
	new_car.flip_sprite()

func _on_timer_timeout():
	spawn_car(%CarSpawn1, CAR_TYPES, randf_range(0.05, 0.4), 300, Vector2.LEFT)
	spawn_car(%CarSpawn2, CAR_TYPES, randf_range(0.05, 0.4), 500, Vector2.LEFT)
	spawn_car(%CarSpawn3, CAR_TYPES, randf_range(0.05, 0.4), 500, Vector2.RIGHT)
	spawn_car(%CarSpawn4, CAR_TYPES, randf_range(0.05, 0.4), 300, Vector2.RIGHT)


func _on_bridge_floor_exit_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
