extends Node2D

class_name Mob

var maxHealth = 10
var health
var moveSpeed = 5.0
var attackDelay = 1
var attackRange = 5
var target: Node2D
var team : TeamManager

signal mobDiead
signal mobNeedsTarget

func _init():
	pass

func _ready():
	pass
	
func initialize(team : TeamManager, target : Node2D):
	self.team = team
	self.target = target
	
func _process(delta):
	move(delta)
	pass

func attack(delta):
	if(target == null):
		return
	pass

func move(delta):
	if(target == null):
		return
	moveToTarget(delta)
	pass
	
func moveToTarget(delta):
	var dir = (position - target.position).normalized()
	position += dir * moveSpeed;
	
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
