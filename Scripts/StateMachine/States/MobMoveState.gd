class_name MobMoveState
extends "res://Scripts/StateMachine/States/MobState.gd"

var moveSpeed: float
var transformNode: Node2D

func get_class(): return "MobMoveState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	moveSpeed = mob.moveSpeed
	
func Process(delta : float) -> bool:
	.Process(delta)
	if(mob.target == null):
		return true
	var vec = mob.target.position - mob.position
	mob.position += vec.clamped(1) * moveSpeed
	return true
