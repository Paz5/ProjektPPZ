class_name MobMoveState
extends "res://Scripts/StateMachine/States/MobState.gd"

var moveSpeed: float
var transformNode: Node2D

func get_class(): return "MobMoveState"

func Initialize(msg := {}) -> void:
	.Initialize(msg)
	moveSpeed = GetProperty("moveSpeed",msg)
	transformNode = GetProperty("transformNode",msg)
	
func Process(delta : float):
	.Process(delta)
	if(target == null):
		target = teamManager.FindTarget()
	var vec = target.position - transformNode.position
	transformNode.position += vec.clamped(1) * moveSpeed
