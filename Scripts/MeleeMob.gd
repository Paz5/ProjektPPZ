extends Mob
func initializeMob(team : TeamManager):
	.initializeMob(team)
	var idleState = get_node("MobIdleState")
	idleState.mob = self
	var moveState = get_node("MobMoveState")
	moveState.mob = self
	var attackState = get_node("MobAttackMeleeState")
	attackState.mob = self
	var deathState = get_node("MobDeathState")
	deathState.mob = self
	mobStateMachine.AddState(idleState)
	mobStateMachine.AddState(moveState)
	mobStateMachine.AddState(attackState)
	mobStateMachine.AddState(deathState)
	
func _process(delta):
	._process(delta)
	if(!active): return
	mobStateMachine.Run(delta)
	if(target==null):
		FindNewTarget()
	if(target==null):
		mobStateMachine.Transition("MobIdleState")
		return
	if((position-target.position).length()<attackRange):
		mobStateMachine.Transition("MobAttackMeleeState")
	else:
		mobStateMachine.Transition("MobMoveState")
