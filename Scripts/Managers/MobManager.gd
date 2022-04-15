extends Node

#temporary arary, in the future pass mobs from a round manager
export(Array, PackedScene) var mobsToSpawn

class_name MobManager
export(Array, NodePath) var teamPaths : Array
var teams : Array

func _ready():
	for teamPath in teamPaths:
		teams.append(get_node(teamPath))
		get_node(teamPath).StartTeam(self)
		get_node(teamPath).spawnMobs(mobsToSpawn)

func FindTargetFor(team : TeamManager):
	if(teams.has(team)):
		var index = (teams.find(team)+1)%teams.size()
		return teams[index].getRandomMob()
	print("No team " + team.name + " in teams collection")
	return null
