class_name Mob
extends Node2D

var maxHealth = 10
var health
var moveSpeed = 1.0
var attackDelay = 1
var attackRange = 50
var velocity = Vector2(0,0)
var target: Node2D
var team : TeamManager

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
	mobStateMachine.AddState(MobMoveState.new(),{"moveSpeed": moveSpeed,"target":target, "teamManager": team})
	mobStateMachine.AddState(MobAttackMeleeState.new(),{"attackDelay": attackDelay,"target": target, "teamManager": team})
	mobStateMachine.Transition("MobMoveState")

	
func _process(delta):
	pass

func damage(damage):
	health -= damage
	if(health < 0):
		onDeath()

func SetTarget(target):
	self.target = target as Node2D

func onDeath():
	GameManager.OnMobKilled(self)
	team.remobeMob(self)
	
func setTeamMaterial(mat : Material):
	get_node("YSort/KinematicBody2D/Sprites/Body").material = mat
	pass

func _on_AttackRange_area_entered(area):
	print(area)
