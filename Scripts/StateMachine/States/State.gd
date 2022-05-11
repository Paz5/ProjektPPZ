class_name State
extends Node2D

var stateMachine = null

func get_class(): return "State"

func SetProperty(name, msg, property):
	if(msg.has(name)):
		property = msg.get(name)
		return
	push_error(get_class() + " lacks " + name)

func UpdateProperties(msg := {}) -> void:
	pass

func Begin():
	pass
	
func Process(delta : float) -> bool:
	return true
	
func End():
	pass
