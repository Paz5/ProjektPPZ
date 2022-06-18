extends "res://Scripts/Projectile.gd"
class_name ArrowProjectile

var timer = 0.0
var travelTime = 0.5
var shootHeight = 100
var height = .01
var fallTime = 1
var lastPos = Vector2(0,0)
var finishedFlight = false

func _ready():
	lastPos = global_position

func _process(delta):	

	global_position = startPos.linear_interpolate(endPos, timer) - Vector2(0,height)

	if(height>0):
		timer += delta/travelTime
		height = shootHeight * sin(deg2rad(timer*90))+.01
		rotation = (global_position-lastPos).angle()
		lastPos = global_position		
		
	elif(!finishedFlight):
		finishedFlight = true
		get_node("AnimatedSprite").animation = "Hit"
		hurtBox.queue_free()



func _on_Hurtbox_area_entered(area):
	queue_free()
	pass # Replace with function body.
