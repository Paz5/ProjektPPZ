class_name Mob
extends KinematicBody2D

export var afterAttackDelay = 0.5
export var maxHealth = 100
var health
export var moveSpeed = 1.0
export var framesBeforeFirstAttack = 0
export var framesBetweenAttacks = 1
export var attackRange = 50
var active = false
export(NodePath) var handContainerPath
export(NodePath) var hurtBoxPath
export(NodePath) var hitBoxPath
export(NodePath) var animatorPath
export(Array, NodePath) var spritePaths
var handContainer: Node2D
var hurtBox: Area2D
var hitBox: Area2D
var sprite

var team: TeamManager
var target: Node2D
var animator: MobAnimator

signal mobDied
signal mobNeedsTarget

export(NodePath) var mobStateMachinePath
var mobStateMachine: StateMachine

func _ready():
	health = maxHealth
	
	
func initializeMob(team : TeamManager):
	self.team = team
	
	animator = get_node(animatorPath)
	mobStateMachine = get_node(mobStateMachinePath)
	handContainer = get_node(handContainerPath)
	hitBox = get_node(hitBoxPath)
	hurtBox = get_node(hurtBoxPath)
	
	var idleState = get_node("MobIdleState")
	idleState.mob = self
	var moveState = get_node("MobMoveState")
	moveState.mob = self
	var deathState = get_node("MobDeathState")
	deathState.mob = self
	var winState = get_node("MobWinState")
	winState.mob = self

	mobStateMachine.AddState(idleState)
	mobStateMachine.AddState(moveState)
	mobStateMachine.AddState(winState)
	mobStateMachine.AddState(deathState)
	
func _process(delta):
	if(!active): return
	pass

func FindNewTarget():
	target = team.FindTarget()
	if(target!=null):
		mobStateMachine.UpdateAllStatesProperties({"target":target})
		animator.target = target
		target.connect("mobDied",self,"TargetDied") ##tu jest już mobDied i wywalało error

func TargetDied():
	target = null

func DealDamage(damage) -> bool:
	emit_signal("mobHit",self)
	health -= damage
	#print(health)
	if(health <= 0):
		onDeath()
		return true
	return false

func onDeath():
	emit_signal("mobDied")   ##więc musiałem wywalić to
	active = false    ##to naprawiło niezabijalność
	mobStateMachine.Transition("MobDeathState",true)
	team.mobDied(self)
	target=null
	hurtBox.queue_free()
	hitBox.queue_free()
	
func setTeamMaterial(mat : Material):
	for path in spritePaths:
		get_node(path).material = mat
		sprite = get_node(path)
	
func _on_AttackRange_area_entered(area):
	#print(area)
	pass
