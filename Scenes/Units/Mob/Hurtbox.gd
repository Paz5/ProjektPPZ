extends Area2D

export var entryDamage: float
export(NodePath) var thisMobPath
var thisMob: Mob

func _ready():
	thisMob = get_node(thisMobPath)

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().name)
	area.get_parent().DealDamage(entryDamage)
