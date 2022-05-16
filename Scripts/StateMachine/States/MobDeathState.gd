extends "res://Scripts/StateMachine/States/MobState.gd"

func get_class(): return "MobDeathState"

func Process(delta : float) -> bool:
	return false
