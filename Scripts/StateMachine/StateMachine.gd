class_name StateMachine
extends Node

var activeState: State = null
var defaultState: State = null
var states: Dictionary
var readyToTransition = false

signal transitioned(stateName)

func Run(delta: float) -> void:
	#if(activeState.Process(delta)):
		#Transition(defaultState.get_class())
	readyToTransition = activeState.Process(delta)
	
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
		

func Transition(stateName: String,override = false) -> void:
	if not states.has(stateName):
		return
		
	if(!readyToTransition && !override):
		return
	
	if(states[stateName] != activeState):
		emit_signal("transitioned",stateName)
		print("transitioned: "+stateName) ##debug
	
	activeState.End()
	activeState = states[stateName]
	activeState.Begin()

