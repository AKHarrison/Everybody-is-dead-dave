extends Node
class_name NewMobState

signal state_transition(new_state_name: String)

var enemy: CharacterBody2D

func _ready():
	enemy = owner

func enter():
	pass

func exit():
	pass

func physics_update(_delta: float):
	pass
