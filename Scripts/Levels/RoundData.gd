extends Node

# Klasa przechowująca informacje o danym poziomie
class_name RoundData

export(NodePath) var redTeamSpawn
export(NodePath) var blueTeamSpawn

var timerText

func _ready():
	RoundManager.CurrentLevel = self
	timerText = get_node("../RoundUI/TimerText")

func GetTimerObject() -> RichTextLabel:
	return timerText
