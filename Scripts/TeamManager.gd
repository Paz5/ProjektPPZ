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
	return mobs[rng.randf_range(0,mobs.size())]

func spawnMob(newMob : Resource):
	var mobInstance = load(newMob.path)
	add_child(mobInstance)
	mobs.append(mobInstance)
	pass

func spawnMobs(newMobs : Array):
	for newMob in newMobs:
		var mobInstance = newMob.instance()
		add_child(mobInstance)
		mobs.append(mobInstance)
		
		var viewportSize = get_viewport().size
		mobInstance.position = Vector2(rng.randf_range(0,viewportSize.x),rng.randf_range(0,viewportSize.y))
	pass
	
func remobeMob(mob):
	if(mobs.has(mob)):
		mobs.remove(mob)
	if(mobs.size()==0):
		emit_signal("allMobsDead")
	pass
