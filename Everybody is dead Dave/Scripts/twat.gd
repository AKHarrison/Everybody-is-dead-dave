extends Area2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var travelled_distance = 0

func _ready() -> void:
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()

func _physics_process(delta):
	const SPEED = 300
	const RANGE = 150
	
	var direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta
	
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
		

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_idle"):
		body.set_idle()
