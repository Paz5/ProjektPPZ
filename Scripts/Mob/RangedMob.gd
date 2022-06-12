extends Mob

export var loadDelay = 0.8
export(NodePath) var projectileOriginPath
var projectileOrigin: Node2D
export(PackedScene) var projectile

func initializeMob(team : TeamManager):
	.initializeMob(team)
	
	projectileOrigin = get_node(projectileOriginPath)
	
	var loadState = get_node("MobAttackRangedState")
	loadState.mob = self
	mobStateMachine.AddState(loadState)
	var fireState = get_node("MobFireRangedState")
	fireState.mob = self
	mobStateMachine.AddState(fireState)
	
func _process(delta):
	._process(delta)
	if(!active): return
	mobStateMachine.Run(delta)
	if(target==null):
		FindNewTarget()
	if(target==null):
		mobStateMachine.Transition("MobWinState") ## Maciej: to nie powinno tu być, bo niektórzy szybciej myślą, że wygrali niż inni
		return
	if((position-target.position).length()<attackRange):
		mobStateMachine.Transition("MobAttackRangedState")
	else:
		mobStateMachine.Transition("MobMoveState")


