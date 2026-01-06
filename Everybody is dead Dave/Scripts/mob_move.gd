class_name State_Mob_Move  extends State

@export var move_speed : float = 100.0
@onready var idle: State_Mob_Idle = $"../Idle"




func Enter() -> void:
	mob.UpdateAnimation("move")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> State:
	if mob.direction == Vector2.ZERO:
		return idle
	
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_delta : InputEvent) -> State:
	return null
