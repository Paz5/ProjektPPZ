extends MobAttackState

var loadTimer = 0.0
var loadDelay
var handContainer

func get_class(): return "MobAttackRangedState"

func UpdateProperties(msg := {}) -> void:
	.UpdateProperties(msg)
	handContainer = mob.handContainer
	loadDelay = mob.loadDelay
	
func Begin():
	.Begin()
	loadTimer = 0
	
func Process(delta : float) -> bool:
	.Process(delta)
	loadTimer += delta
	if(loadTimer>loadDelay):
		stateMachine.readyToTransition = true
		stateMachine.Transition("MobFireRangedState")
		loadTimer = 0
	return false
	
func End():
	.End()
	pass
