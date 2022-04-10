extends Node2D

class_name Mob

var maxHealth = 10
var health
var moveSpeed = 5.0
var target: Node2D
var team : TeamManager

signal mobDiead
signal mobNeedsTarget



func _init():
	pass

func _ready():
	pass
	
func initialize(mobTeam : TeamManager):
	team = mobTeam
	pass

func _process(delta):
	pass

func attack():
	pass

func move():
	pass
	
func damage(damage):
	health -= damage
	if(health < 0):
		onDeath()

func SetTarget(target):
	self.target = target as Node2D

func onDeath():
	team.remobeMob(self)
