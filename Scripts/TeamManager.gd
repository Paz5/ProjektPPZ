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

signal teamDied(teamIndex)

func _init():
	rng.randomize()

func StartTeam(mobManager):
	self.mobManager = mobManager

func FindTarget():
	return mobManager.FindTargetFor(self)
	
func getRandomMob():
	if(mobs.size()>0):
		return mobs[rng.randf_range(0,mobs.size())]
	return null
	
func setAllMobsAcctivity(isActive: bool):
	for mob in mobs:
		mob.active = isActive

func spawnMobs(newMobs : Array):
	for newMob in newMobs:
		var rand = rng.randf_range(0,1)
		if(rand > 0.5):
			continue
		
		
		var mobInstance = newMob.instance()
		add_child(mobInstance)
		mobs.append(mobInstance)
	
		mobInstance.initializeMob(self)

		var viewportSize = get_viewport().size
		if teamIndex==0:
			mobInstance.position = Vector2(rng.randf_range(viewportSize.x-(viewportSize.x/3),viewportSize.x-(viewportSize.x/11)),rng.randf_range(viewportSize.y/3,viewportSize.y-(viewportSize.y/11)))
		else :
			mobInstance.position = Vector2(rng.randf_range(viewportSize.x/11,viewportSize.x/3),rng.randf_range(viewportSize.y/3,viewportSize.y-(viewportSize.y/11)))
		mobInstance.setTeamMaterial(teamMaterial)
		var id = teamIndex * 2

		mobInstance.hitBox.set_collision_layer(pow(2, id))
		if(mobInstance.hurtBox != null):
			mobInstance.hurtBox.set_collision_layer(pow(2, id+1))
		mobInstance.hitBox.set_collision_mask(teamLayerDictionary.get(id))
		if(mobInstance.hurtBox != null):
			mobInstance.hurtBox.set_collision_mask(teamLayerDictionary.get(id+1))
	
func mobDied(mob):
	if(mobs.has(mob)):
		mobs.erase(mob)
		
	if(mobs.size()==0):
		emit_signal("teamDied", teamIndex)
