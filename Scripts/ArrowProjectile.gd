extends "res://Scripts/Projectile.gd"
class_name ArrowProjectile

var timer = 0.0
var travelTime = 0.5
var shootHeight = 100
var height = .01
var fallTime = 1
var lastPos = Vector2(0,0)

func _ready():
	lastPos = global_position

func _process(delta):	

	global_position = startPos.linear_interpolate(endPos, timer) - Vector2(0,height)

	if(height>0):
		timer += delta/travelTime
		height = shootHeight * sin(deg2rad(timer*90))+.01
		rotation = (global_position-lastPos).angle()
		lastPos = global_position
	
