class_name Mob
extends Node2D

export var maxHealth = 10
var health
export var moveSpeed = 1.0
export var attackDelay = 1
export var attackRange = 50
var team: TeamManager
var target: Node2D
var animator: MobAnimator

signal mobDiead
signal mobNeedsTarget

var mobStateMachine: StateMachine

func _ready():
	health = maxHealth

	
func initializeMob(team : TeamManager, target : Node2D):
	self.team = team
	self.target = target
	
	mobStateMachine = StateMachine.new()
	mobStateMachine.AddState(MobIdleState.new(),{"target":target, "teamManager": team})
	mobStateMachine.AddState(MobMoveState.new(),{"moveSpeed": moveSpeed,"transformNode": self,"target":target, "teamManager": team})
	mobStateMachine.AddState(MobAttackMeleeState.new(),{"attackDelay": attackDelay,"target": target, "teamManager": team})

	
func _process(delta):
	mobStateMachine.Run(delta)
	if(target==null):
		FindNewTarget()
	if(target==null):
		mobStateMachine.Transition("MobIdleState",true)
		return
	if((position-target.position).length()<attackRange):
		mobStateMachine.Transition("MobAttackState")
	else:
		mobStateMachine.Transition("MobMoveState")

func FindNewTarget():
	target = team.FindTarget()
	if(target!=null):
		mobStateMachine.UpdateAllStatesProperties({"target":target})

func damage(damage):
	health -= damage
	if(health < 0):
		onDeath()

func onDeath():
	GameManager.OnMobKilled(self)
	team.remobeMob(self)
	
func setTeamMaterial(mat : Material):
	get_node("YSort/KinematicBody2D/Sprites/Body").material = mat

func _on_AttackRange_area_entered(area):
	print(area)
