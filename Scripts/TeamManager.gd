extends Node

class_name TeamManager

var teamLayerDictionary = {	0 : 0b0001010100, #niebieski hit zadają obrażenia
							1 : 0b0010101011, #niebieski hurt otrzymują obrażenia
							2 : 0b0100010100, #czerwony hit
							3 : 0b1000101011, #czerwony hurt
							4 : 0b0101000100, #fioletowy hit
							5 : 0b1010001011, #fioletowy hurt
							6 : 0b0101010000, #żółty hit
							7 : 0b1010100011, #żółty hurt
							}

export var teamMaterial : Material
var teamIndex : int
var mobManager
var mobs : Array
var rng = RandomNumberGenerator.new()

func _init():
	rng.randomize()

func StartTeam(mobManager):
	self.mobManager = mobManager

func FindTarget():
	return mobManager.FindTargetFor(self)
	
func getRandomMob():
	return mobs[rng.randf_range(0,mobs.size())]

func spawnMobs(newMobs : Array):
	for newMob in newMobs:
		var mobInstance = newMob.instance()
		add_child(mobInstance)
		mobs.append(mobInstance)
	
		mobInstance.initializeMob(self)

		var viewportSize = get_viewport().size
		mobInstance.position = Vector2(rng.randf_range(0,viewportSize.x),rng.randf_range(0,viewportSize.y))
		mobInstance.setTeamMaterial(teamMaterial)
		mobInstance.hurtBox.set_collision_layer(pow(2, teamIndex))
		mobInstance.hurtBox.set_collision_mask(teamLayerDictionary.get(teamIndex))
	
func remobeMob(mob):
	if(mobs.has(mob)):
		mobs.remove(mob)
		
	if(mobs.size()==0):
		GameManager.OnAllMobsDead()
		#emit signal zamiast wywołania funkcji
