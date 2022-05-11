class_name MobAttackMeleeState
extends "res://Scripts/StateMachine/States/MobAttackState.gd"

var attackTimer = 0.0
var attackDelay
var handContainer
var hitBox

func get_class(): return "MobAttackMeleeState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	SetProperty("handContainer",msg,handContainer)
	SetProperty("attackDelay",msg,attackDelay)
	SetProperty("hitBox",msg,hitBox)
	
func Begin():
	.Begin()
	attackTimer = 0.0
	
func Process(delta : float) -> bool:
	.Process(delta)
	attackTimer += delta
	if(attackTimer>attackDelay):
		MeleeAttack()
		attackTimer = 0
		return true
	return false
	
func MeleeAttack():
	pass
	
func End():
	.End()
	pass
