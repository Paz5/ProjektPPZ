class_name StateMachine
extends Node

var activeState: State = null
var defaultState: State = null
var states: Dictionary

signal transitioned(stateName)

func Run(delta: float) -> void:
	if(activeState.Process(delta)):
		Transition(defaultState.get_class())
	
func AddState(newState: State, msg : = {}) -> void:
	if(states.has(newState.get_class())):
		return
	states[newState.get_class()] = newState
	newState.UpdateProperties(msg)
	if(activeState == null):
		activeState = newState
		defaultState = newState
	activeState.Begin()
	emit_signal("transitioned",activeState.name)
	
func UpdateAllStatesProperties(msg := {}):
	for state in states.values():
		state.UpdateProperties(msg)
		

func Transition(stateName: String) -> void:
	if not states.has(stateName):
		return
	
	if(states[stateName] != activeState):
		emit_signal("transitioned",stateName)
	
	activeState.End()
	activeState = states[stateName]
	activeState.Begin()

