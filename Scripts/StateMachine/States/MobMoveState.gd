class_name MobMoveState
extends "res://Scripts/StateMachine/States/MobState.gd"

var moveSpeed: float
var transformNode: Node2D

func get_class(): return "MobMoveState"


func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	SetProperty("moveSpeed",msg,moveSpeed)
	SetProperty("transformNode",msg, transformNode)
	
func Process(delta : float) -> bool:
	.Process(delta)
	if(target == null):
		return true
	var vec = target.position - transformNode.position
	transformNode.position += vec.clamped(1) * moveSpeed
	return true
