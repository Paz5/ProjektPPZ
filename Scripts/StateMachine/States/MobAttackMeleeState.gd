class_name MobAttackMeleeState
extends "res://Scripts/StateMachine/States/MobAttackState.gd"

var attackTimer = 0.0
var afterAttackTimer = 0.0
var canAttack = true
var attackDelay
var fbfa
var fba
var handContainer
var hurtBox
var hurtBoxCollider : CollisionShape2D
var firstAttack = true


func get_class(): return "MobAttackMeleeState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	handContainer = mob.handContainer
	fbfa = mob.framesBeforeFirstAttack
	fba = mob.framesBetweenAttacks
	hurtBox = mob.hurtBox
	hurtBoxCollider = hurtBox.get_child(0)
	attackDelay = fba/10
	
	
func Begin():
	.Begin()
	attackTimer = 0.0
	
func Process(delta : float) -> bool:
	#hurtBoxCollider.disabled = true
	.Process(delta)
	attackTimer += delta
	#print(attackTimer)
	if(firstAttack):
		if(attackTimer>fbfa/10):
			if(canAttack):
				MeleeAttack()
				canAttack=false
			afterAttackTimer += delta
			if(afterAttackTimer>mob.afterAttackDelay):
				attackTimer = 0.0
				afterAttackTimer = 0.0
				firstAttack=false
				canAttack=true
				return true
	else:
		if(attackTimer>attackDelay):
			if(canAttack):
				MeleeAttack()
				canAttack=false
			afterAttackTimer += delta
			if(afterAttackTimer>mob.afterAttackDelay):
				attackTimer = 0.0
				afterAttackTimer = 0.0
				canAttack=true
				return true
	return false
	
func MeleeAttack():
	#hurtBoxCollider.disabled = false
	get_node("../Animator/HandContainer/Hurtbox").deal_damage()
	get_node("../AudioStreamPlayer").play()
	pass
	
func End():
	.End()
	pass
