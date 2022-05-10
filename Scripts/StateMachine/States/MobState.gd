extends "res://State.gd"

func get_class(): return "MobState"

var target
var teamManager

func Initialize(msg := {}) -> void:
	target = GetProperty("target",msg)
	teamManager = GetProperty("teamManager",msg)
