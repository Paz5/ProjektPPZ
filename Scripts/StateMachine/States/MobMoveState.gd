class_name MobMoveState
extends "res://Scripts/StateMachine/States/MobState.gd"

var moveSpeed: float
var transformNode: Node2D

func get_class(): return "MobMoveState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	moveSpeed = mob.moveSpeed
	
var moveVector = Vector2(0,0)

func Process(delta : float) -> bool:
	.Process(delta)
	if(mob.target == null):
		return true
	moveVector = (mob.target.global_position - mob.global_position).clamped(1) * moveSpeed
	#mob.move_and_slide(moveVector,Vector2(0,0),false,4,0.78,false)
	mob.move_and_collide(moveVector * delta,true)
	return true
	
func _physics_process(delta):
	pass
