extends Area2D

export var entryDamage: float
export(NodePath) var thisMobPath
var thisMob: Mob
var enemyMobs = []

func _ready():
	thisMob = get_node(thisMobPath)

func _on_Hurtbox_area_entered(area):
	if area.get_parent().team.teamIndex!=thisMob.team.teamIndex:
		print(area.get_parent().name)
		if (area.get_parent().active) && (!enemyMobs.has(area.get_parent())):
			enemyMobs.append(area.get_parent()) 
		
	
	
func deal_damage():
	if enemyMobs.size()!=0:
		for m in enemyMobs:
			if m.health>0:
				m.DealDamage(entryDamage)
			else:
				m.onDeath()
				enemyMobs.erase(m)
			
			


func _on_Hurtbox_area_exited(area):
	if enemyMobs.has(area.get_parent()):
		enemyMobs.erase(area.get_parent())
		

##debug
func printAllEnemiesInHurtRange():
	for m in enemyMobs:
		print(m.name)
