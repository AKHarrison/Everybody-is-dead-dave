class_name State_Move  extends State

@export var move_speed : float = 150.0
@onready var idle: State_Idle = $"../Idle"



func Enter() -> void:
	player.UpdateAnimation("move")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation(("move"))
	
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_delta : InputEvent) -> State:
	return null
