extends Node

class_name TeamManager

export var teamMaterial : Material
var mobManager
var mobs : Array
var rng = RandomNumberGenerator.new()

func _init():
	rng.randomize()

func StartTeam(mobManager):
	self.mobManager = mobManager

func FindTarget(mob):
	return mobManager.FindTargetFor(self)
	
func getRandomMob():
	return mobs[rng.randf_range(0,mobs.size())]

func spawnMobs(newMobs : Array):
	for newMob in newMobs:
		var mobInstance = newMob.instance()
		add_child(mobInstance)
		mobs.append(mobInstance)
		
		mobInstance.initializeMob(self,FindTarget(mobInstance))
		var viewportSize = get_viewport().size
		mobInstance.position = Vector2(rng.randf_range(0,viewportSize.x),rng.randf_range(0,viewportSize.y))
		mobInstance.setTeamMaterial(teamMaterial)
	
func remobeMob(mob):
	if(mobs.has(mob)):
		mobs.remove(mob)
		
	if(mobs.size()==0):
		GameManager.OnAllMobsDead()
