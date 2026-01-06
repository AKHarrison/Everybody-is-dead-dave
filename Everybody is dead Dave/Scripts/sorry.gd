extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 200
	const RANGE = 150
	
	var direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
		

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("send_home"):
		body.send_home()
