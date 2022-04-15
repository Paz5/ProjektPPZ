extends Node2D

class_name Mob

var maxHealth = 10
var health
var moveSpeed = 1.0
var attackDelay = 1
var attackRange = 50
var target: Node2D
var team : TeamManager

signal mobDiead
signal mobNeedsTarget

func _init():
	health = maxHealth
	pass

func _ready():
	pass
	
func initializeMob(team : TeamManager, target : Node2D):
	self.team = team
	self.target = target
	
func _process(delta):
	move(delta)
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
	
func damage(damage):
	health -= damage
	if(health < 0):
		onDeath()

func SetTarget(target):
	self.target = target as Node2D

func onDeath():
	team.remobeMob(self)
	
func setTeamMaterial(mat : Material):
	get_node("YSort/KinematicBody2D/Sprites/Body").material = mat
	pass
