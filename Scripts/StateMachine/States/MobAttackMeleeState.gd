class_name MobAttackMeleeState
extends "res://Scripts/StateMachine/States/MobAttackState.gd"

var attackTimer = 0.0
var attackDelay
var handContainer
var hitBox

func get_class(): return "MobAttackMeleeState"

func Initialize(msg := {}) -> void:
	.Initialize(msg)
	handContainer = GetProperty("handContainer",msg)
	attackDelay = GetProperty("attackDelay",msg)
	hitBox = GetProperty("hitBox",msg)
	
func Begin():
	.Begin()
	attackTimer = 0.0
	
func Process(delta : float):
	.Process(delta)
	attackTimer += delta
	if(attackTimer>attackDelay):
		MeleeAttack()
		attackTimer = 0
	
func MeleeAttack():
	pass
	
func End():
	.End()
	pass
