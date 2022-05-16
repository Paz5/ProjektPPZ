extends Node

class_name TeamManager
								# 12345678
var teamLayerDictionary = {	0 : 0b10101000, #czerwony hit otrzymują obrażenia
							1 : 0b01010100, #czerwony hurt zadają obrażenia
							2 : 0b10100010, #niebieski hit
							3 : 0b01010001, #niebieski hurt
							4 : 0b10001010, #fioletowy hit
							5 : 0b01000101, #fioletowy hurt
							6 : 0b00101010, #żółty hit
							7 : 0b00010101, #żółty hurt
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
	
func setAllMobsAcctivity(isActive: bool):
	for mob in mobs:
		mob.active = isActive

func spawnMobs(newMobs : Array):
	for newMob in newMobs:
		var mobInstance = newMob.instance()
		add_child(mobInstance)
		mobs.append(mobInstance)
	
		mobInstance.initializeMob(self)

		var viewportSize = get_viewport().size
		mobInstance.position = Vector2(rng.randf_range(0,viewportSize.x),rng.randf_range(0,viewportSize.y))
		mobInstance.setTeamMaterial(teamMaterial)
		var id = teamIndex * 2

		mobInstance.hitBox.set_collision_layer(pow(2, id))
		mobInstance.hurtBox.set_collision_layer(pow(2, id+1))
		mobInstance.hitBox.set_collision_mask(teamLayerDictionary.get(id))
		mobInstance.hurtBox.set_collision_mask(teamLayerDictionary.get(id+1))
	
func mobDied(mob):
	if(mobs.has(mob)):
		mobs.remove(mob)
		
	if(mobs.size()==0):
		GameManager.OnAllMobsDead()
		#emit signal zamiast wywołania funkcji
