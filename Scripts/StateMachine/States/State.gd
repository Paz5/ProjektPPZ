class_name State
extends Node2D

var stateMachine = null

func get_class(): return "State"

func GetProperty(name, _msg):
	if(_msg.has(name)):
		return _msg.get(name)
	push_error(get_class() + " lacks " + name)
	return null

func Initialize(_msg := {}) -> void:
	pass

func Begin():
	pass
	
func Process(delta : float) -> bool:
	return false
	
func End():
	pass
