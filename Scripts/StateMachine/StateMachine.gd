class_name StateMachine
extends Node

var activeState: State = null
var states: Dictionary

func Run(delta: float) -> void:
	if(activeState.Process(delta)):
		Transition(states[0].get_class())
	
func AddState(newState: State, msg : Dictionary = {}) -> void:
	if(states.has(newState.get_class())):
		return
	states[newState.get_class()] = newState
	newState.Initialize(msg)
	if(activeState == null):
		activeState = newState
	
func Transition(stateName: String) -> void:
	if not states.has(stateName):
		return
	
	activeState.End()
	activeState = states[stateName]
	activeState.Begin()
	emit_signal("transitioned",activeState.name)
