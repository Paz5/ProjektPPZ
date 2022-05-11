class_name StateMachine
extends Node

var activeState: State = null
var states: Dictionary
var activeStateFinished = false


func Run(delta: float) -> void:
	activeStateFinished = activeState.Process(delta)
	
func AddState(newState: State, msg : = {}) -> void:
	if(states.has(newState.get_class())):
		return
	states[newState.get_class()] = newState
	newState.UpdateProperties(msg)
	if(activeState == null):
		activeState = newState
	
func UpdateAllStatesProperties(msg := {}):
	for state in states.values():
		state.UpdateProperties(msg)
		

func Transition(stateName: String, ovveride = false) -> void:
	if(!activeStateFinished && !ovveride):
		return
	if not states.has(stateName):
		return
	
	activeState.End()
	activeState = states[stateName]
	activeState.Begin()
	emit_signal("transitioned",activeState.name)
