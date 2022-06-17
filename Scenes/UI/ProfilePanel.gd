extends Control
class_name ProfilePanel

func Init(var rankIndex, var playerName, var level, var totalWinRatio):
	get_node("HBoxContainer/RankLabel").text = str(rankIndex) + ":"
	get_node("HBoxContainer/PlayerNameLabel").text = playerName
	get_node("HBoxContainer/LevelLabel").text = str(level)
	get_node("HBoxContainer/TotalWinRatioLabel").text = str(totalWinRatio)
