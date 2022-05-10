class_name MobState
extends "res://Scripts/StateMachine/States/State.gd"

func get_class(): return "MobState"

var target: Node2D 
var teamManager: TeamManager

func Initialize(msg := {}) -> void:
	target = GetProperty("target",msg)
	teamManager = GetProperty("teamManager",msg)
