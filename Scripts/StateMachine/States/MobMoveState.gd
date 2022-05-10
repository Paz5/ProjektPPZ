class_name MobMoveState
extends "res://Scripts/StateMachine/States/MobState.gd"

var moveSpeed

func get_class(): return "MobMoveState"

func Initialize(msg := {}) -> void:
	.Initialize(msg)
	moveSpeed = GetProperty("moveSpeed",msg)
	
func Process(delta : float):
	.Process(delta)
	var vec = target.position - position
	position += vec.clamped(1) * moveSpeed
