extends Node

var teams : Array

var rng = RandomNumberGenerator.new()

func _ready():
	for team in teams:
		team.StartTeam()
