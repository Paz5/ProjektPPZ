class_name MobFireRangedState
extends "res://Scripts/StateMachine/States/MobState.gd"

func get_class(): return "MobFireRangedState"

var attackTimer = 0.0
var attackDelay

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	attackDelay = mob.attackDelay

	
func Process(delta : float) -> bool:
	attackTimer += delta
	if(attackTimer>attackDelay):
		attackTimer = 0
		return true
	return false
