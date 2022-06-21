class_name MobFireRangedState
extends "res://Scripts/StateMachine/States/MobState.gd"

func get_class(): return "MobFireRangedState"

var projectile: PackedScene
var attackTimer = 0.0
var attackDelay
var fbfa
var fba
var firstAttack = true

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	fbfa = mob.framesBeforeFirstAttack
	fba = mob.framesBetweenAttacks
	attackDelay = fba/10
	projectile = mob.projectile

	
func Process(delta : float) -> bool:
	attackTimer += delta
	if(firstAttack):
		if(attackTimer>fbfa/10):
			if(mob.target!=null):
				SpawnProjectile()
				attackTimer = 0
				firstAttack=false
				return true
	else:
		if(attackTimer>attackDelay):
			if(mob.target!=null):
				SpawnProjectile()
			attackTimer = 0
			return true
	return false
	
func SpawnProjectile():
	var b = projectile.instance()
	get_parent().add_child(b)
	b.startPos = mob.projectileOrigin.global_position
	b.endPos = mob.target.global_position
	
	b.sprite.material = mob.sprite.material
	b.hurtBox.set_collision_mask(mob.hurtBox.get_collision_mask())
	b.hurtBox.set_collision_layer(mob.hurtBox.get_collision_layer())
