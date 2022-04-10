extends Node

class_name TeamManager

var mobs : Array

signal allMobsDead

func StartTeam():
	#spawn all mobs	
	pass

func spawnMob(mob):
	mobs.append(mob)
	#spawn(mob)
	#mob.Initialize(self)
	pass
	
func remobeMob(mob):
	if(mobs.has(mob)):
		mobs.remove(mob)
	if(mobs.size()==0):
		emit_signal("allMobsDead")
	pass
