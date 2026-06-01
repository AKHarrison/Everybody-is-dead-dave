extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.z_index = 0
		body.set_collision_mask_value(5, false)
		body.set_collision_layer_value(5, false)
		body.set_collision_mask_value(1, true)
		body.set_collision_layer_value(1, true)
