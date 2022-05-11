class_name MobState
extends "res://Scripts/StateMachine/States/State.gd"

func get_class(): return "MobState"

var target: Node2D 
var teamManager: TeamManager

func UpdateProperties(msg := {}) -> void:
	SetProperty("target",msg,target)
	SetProperty("teamManager",msg,teamManager)
