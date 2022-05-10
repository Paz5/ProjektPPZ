extends Node2D

class_name Mob

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

func attack(delta):
	if(target == null):
		target = team.FindTarget(self)
		return
	pass

func move(delta):
	if(target == null):
		target = team.FindTarget(self)
		return
	moveToTarget(delta)
	pass
	
func moveToTarget(delta):
	var vec = target.position - position
	if vec.length() > attackRange:
		position += vec.clamped(1) * moveSpeed;
		
	var angle=get_angle_to(target.global_position)
	velocity.x=cos(angle)
	velocity.y=cos(angle)
	if velocity.x > 0:
		flipSprites(false)
	elif velocity.x < 0:
		flipSprites(true)
		
func flipSprites(state):
	get_node("YSort/KinematicBody2D/Sprites/Body").set_flip_h(state)
	get_node("YSort/KinematicBody2D/Sprites/BackHand").set_flip_h(state)
	get_node("YSort/KinematicBody2D/Sprites/FrontHand").set_flip_h(state)
	
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
