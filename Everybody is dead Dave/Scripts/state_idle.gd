class_name State_Idle  extends State
@onready var move: State_Move = $"../Move"


func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return move
		
	player.velocity = Vector2.ZERO
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_delta : InputEvent) -> State:
	return null
