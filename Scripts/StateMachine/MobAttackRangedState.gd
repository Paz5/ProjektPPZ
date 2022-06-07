extends MobAttackState

var attackTimer = 0.0
var attackDelay
var handContainer

func get_class(): return "MobAttackRangedState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	handContainer = mob.handContainer
	attackDelay = mob.attackDelay
	
func Begin():
	.Begin()
	attackTimer = 0.5
	
func Process(delta : float) -> bool:
	.Process(delta)
	attackTimer += delta
	if(attackTimer>attackDelay):
		RangedAttack()
		attackTimer = 0.0
		#return false w domyśle
	return false
	
func RangedAttack():
	
	pass
	
func PrepareProjectile():
	pass
	
func LaunchProjectile():
	pass
	
func End():
	.End()
	pass
