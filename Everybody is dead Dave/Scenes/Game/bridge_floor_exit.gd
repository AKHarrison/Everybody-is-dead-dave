extends Area2D

var body_z_index = 1

func exit_on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.z_index == body_z_index:
			body.z_index = 0
			body.set_collision_mask_value(1, true)
			body.set_collision_layer_value(1, true)
			body.set_collision_mask_value(5, false)
			body.set_collision_layer_value(5, false)

func exit_on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.z_index = 1
		body.set_collision_layer_value(1, false)
		body.set_collision_mask_value(1, false)
		body.set_collision_mask_value(5, true)
		body.set_collision_layer_value(5, true)
