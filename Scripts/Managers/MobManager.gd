extends Node

#temporary arary, in the future pass mobs from a round manager
export(Array, PackedScene) var mobsToSpawn

class_name MobManager
export(Array, NodePath) var teamPaths : Array
var teams : Array

func _ready():
	var i = 0
	for teamPath in teamPaths:
		teams.append(get_node(teamPath))
		get_node(teamPath).teamIndex = i
		get_node(teamPath).StartTeam(self)
		get_node(teamPath).spawnMobs(mobsToSpawn)
		
		i+= 1
	
	GameManager.connect("BetConfirmed",self,"OnBetConfirmed")
		

func OnBetConfirmed():
	for team in teams:
		team.setAllMobsAcctivity(true)
	pass

func FindTargetFor(targetTeam : TeamManager):
	if(teams.has(targetTeam)):
		teams.shuffle()
		for team in teams:
			if(team != targetTeam):
				return team.getRandomMob()
		print("Couldn't find team other than " + targetTeam.name)
		return null
	
	print("No team " + targetTeam.name + " in teams collection")
	return null
