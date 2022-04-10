extends Node

class_name MobManager
export(Array, NodePath) var teamPaths : Array
var teams : Array

func _ready():
	for teamPath in teamPaths:
		teams.append(get_node(teamPath))
		get_node(teamPath).StartTeam(self)

func FindTargetFor(team : TeamManager):
	if(teams.has(team)):
		var index = (teams.find(team)+1)%teams.size()
		return teams[index].findRandomMob()
	print("No team " + team.name + " in teams collection")
	return null
