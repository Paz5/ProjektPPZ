extends Mob

func initializeMob(team : TeamManager):
	.initializeMob(team)
	hurtBox = get_node(hurtBoxPath)
	var attackState = get_node("MobAttackMeleeState")
	attackState.mob = self
	mobStateMachine.AddState(attackState)
	
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
		mobStateMachine.Transition("MobAttackMeleeState")
	else:
		mobStateMachine.Transition("MobMoveState")


