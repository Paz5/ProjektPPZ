class_name MobState
extends "res://Scripts/StateMachine/States/State.gd"

func get_class(): return "MobState"

var target
var teamManager

func Initialize(msg := {}) -> void:
	target = GetProperty("target",msg)
	teamManager = GetProperty("teamManager",msg)
