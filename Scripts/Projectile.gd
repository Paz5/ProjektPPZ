extends Node2D
class_name Projectile

var hurtBox: Area2D
export(NodePath) var hurtBoxPath
var startPos: Vector2
var endPos: Vector2

func _ready():
	hurtBox = get_node(hurtBoxPath)
	pass
