extends Area2D

@export var z_index_value: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.z_index = z_index_value
		body.set_collision_layer_value(1, false)  # disable ground
		body.set_collision_mask_value(1, false)  # disable ground
		body.set_collision_mask_value(5, true)   # re-enable ground
		body.set_collision_layer_value(5, true)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.set_collision_mask_value(1, true)   # re-enable ground
		body.set_collision_layer_value(1, true)
		body.set_collision_mask_value(5, false)   # re-enable ground
		body.set_collision_layer_value(5, false)
