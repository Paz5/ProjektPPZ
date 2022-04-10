extends Node

class_name TeamManager

var mobManager
var mobs : Array
var rng = RandomNumberGenerator.new()

signal allMobsDead

func StartTeam(mobManager):
	self.mobManager = mobManager
	#spawn all mobs	
	pass

func FindTarget(mob):
	mob.SetTarget(mobManager.FindTargetFor(self))
	pass
	
func getRandomMob():
	return mobs[rng.range(0,mobs.size())]

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
