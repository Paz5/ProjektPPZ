extends Node

# Klasa przechowująca informacje o danym poziomie
class_name RoundData

export(NodePath) var redTeamSpawn
export(NodePath) var blueTeamSpawn

var mobManager
var timerText

func _ready():
	RoundManager.CurrentLevel = self
	timerText = get_node("../RoundUI/TimerText")
	mobManager = get_node("../MobManager")

func GetTimerObject() -> RichTextLabel:
	return timerText

func GetMobManager() -> MobManager:
	return mobManager
