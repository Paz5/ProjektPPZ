class_name MobAttackMeleeState
extends "res://Scripts/StateMachine/States/MobAttackState.gd"

var attackTimer = 0.0
var attackDelay
var handContainer
var hurtBox
var hurtBoxCollider : CollisionShape2D

func get_class(): return "MobAttackMeleeState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	handContainer = mob.handContainer
	attackDelay = mob.attackDelay
	hurtBox = mob.hurtBox
	hurtBoxCollider = hurtBox.get_child(0)
	
func Begin():
	.Begin()
	attackTimer = 0.5
	
func Process(delta : float) -> bool:
	#hurtBoxCollider.disabled = true
	.Process(delta)
	attackTimer += delta
	#print(attackTimer)
	if(attackTimer>attackDelay):
		MeleeAttack()
		attackTimer = 0.0
		return true
	return false
	
func MeleeAttack():
	#hurtBoxCollider.disabled = false
	get_node("../Animator/HandContainer/Hurtbox").deal_damage()
	pass
	
func End():
	.End()
	pass
