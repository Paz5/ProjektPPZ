extends Container
class_name ProfilePanel

func Init(var rankIndex, var playerName, var level, var totalWinRatio):
	get_node("HBoxContainer/Left1/RankLabel").text = str(rankIndex) + ":"
	get_node("HBoxContainer/Left2/PlayerNameLabel").text = playerName
	get_node("HBoxContainer/Right1/LevelLabel").text = str(level)
	get_node("HBoxContainer/Right2/TotalWinRatioLabel").text = str(totalWinRatio)
