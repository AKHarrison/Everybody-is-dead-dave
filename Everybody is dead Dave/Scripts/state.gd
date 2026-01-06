class_name State extends Node

static var player: Player

# Called when th e node enters the scene tree for the first time.
func _ready() -> void:
	pass

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> State:
	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_delta : InputEvent) -> State:
	return null
