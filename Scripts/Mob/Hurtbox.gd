extends Area2D

export var entryDamage: float
var teamIndex
var thisMob: Mob
var enemyMobs = []
export var dealDamageOnEntry = false


func _on_Hurtbox_area_entered(area):
	if area.get_parent().team.teamIndex!=teamIndex:
		#print(area.get_parent().name)
		if (area.get_parent().active) && (!enemyMobs.has(area.get_parent())):
			var m = area.get_parent()
			enemyMobs.append(m)
			if(dealDamageOnEntry):
				if m.health>0:
					m.DealDamage(entryDamage)
					print(entryDamage)

	
	
func deal_damage():
	if enemyMobs.size()!=0:
		for m in enemyMobs:
			if m.health>0:
				m.DealDamage(entryDamage)
				print(entryDamage)
			#else:
			#	m.onDeath()
			#	enemyMobs.erase(m)
			#	print("Dead")
			
			


func _on_Hurtbox_area_exited(area):
	if enemyMobs.has(area.get_parent()):
		enemyMobs.erase(area.get_parent())
		

##debug
func printAllEnemiesInHurtRange():
	for m in enemyMobs:
		print(m.name)
