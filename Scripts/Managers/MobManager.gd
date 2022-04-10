extends Node

enum team {first,second}

var firstTeam : Array
var secondTeam : Array

signal allMobsDead

var rng = RandomNumberGenerator.new()

func addMob(mob,team):
	if(team == team.first):
		firstTeam.append(mob)
	if(team == team.second):
		firstTeam.append(mob)

func removeMob(mob):
	if(firstTeam.has(mob)):
		firstTeam.remove(mob)
	if(secondTeam.has(mob)):
		secondTeam.remove(mob)
		
	if(firstTeam.empty() && secondTeam.empty()):
		emit_signal("allMobsDead")

func randomMob(team):
	if(team == team.first):
		return firstTeam[rng.range(0,firstTeam.size())]
	if(team == team.second):
		return firstTeam[rng.range(0,secondTeam.size())]


func _ready():
	pass # Replace with function body.

