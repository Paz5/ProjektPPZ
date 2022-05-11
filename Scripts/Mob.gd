class_name Mob
extends Node2D

export var maxHealth = 10
var health
export var moveSpeed = 1.0
export var attackDelay = 1
export var attackRange = 50
export(NodePath) var handContainerPath
export(NodePath) var hurtBoxPath
export(NodePath) var animatorPath
export(Array, NodePath) var spritePaths
var handContainer: Node2D
var hurtBox: CollisionShape2D


var team: TeamManager
var target: Node2D
var animator: MobAnimator

signal mobDiead
signal mobNeedsTarget

export(NodePath) var mobStateMachinePath
var mobStateMachine: StateMachine

func _ready():
	health = maxHealth
	animator = get_node(animatorPath)
	mobStateMachine = get_node(mobStateMachinePath)
	handContainer = get_node(handContainerPath)
	hurtBox = get_node(hurtBoxPath)

	
func initializeMob(team : TeamManager):
	self.team = team

	var idleState = get_node("MobIdleState")
	idleState.mob = self
	var moveState = get_node("MobMoveState")
	moveState.mob = self
	var attackState = get_node("MobAttackMeleeState")
	attackState.mob = self
	mobStateMachine.AddState(idleState)
	mobStateMachine.AddState(moveState)
	mobStateMachine.AddState(attackState)
	
func _process(delta):
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

func FindNewTarget():
	target = team.FindTarget()
	if(target!=null):
		mobStateMachine.UpdateAllStatesProperties({"target":target})
		animator.target = target

func damage(damage):
	health -= damage
	if(health < 0):
		onDeath()

func onDeath():
	GameManager.OnMobKilled(self)
	team.remobeMob(self)
	
func setTeamMaterial(mat : Material):
	for path in spritePaths:
		get_node(path).material = mat
	
func _on_AttackRange_area_entered(area):
	print(area)
