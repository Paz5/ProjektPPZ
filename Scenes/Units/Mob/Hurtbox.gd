extends Area2D

export var entryDamage: float
export(NodePath) var thisMobPath
var thisMob: Mob
var enemyMob = null

func _ready():
	thisMob = get_node(thisMobPath)

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().name)
	if area.get_parent().active:
		enemyMob = area.get_parent()
	
	
func deal_damage():
	if enemyMob!=null:
		if enemyMob.active:
			enemyMob.DealDamage(entryDamage)
		else:
			enemyMob=null


func _on_Hurtbox_area_exited(area):
	if area.get_parent()==enemyMob:
		enemyMob=null
