extends Node

var playerNameLabel
var levelLabel
var gamePlayedLabel
var winRatioLabel

func _ready():
	get_node("Control/Panel/DescriptionPanelLeft/PlayerName").text = PlayerProfileManager.CurrentSelectedProfile.profileName
	get_node("Control/Panel/DescriptionPanelLeft/Level").text = "Level: " + str(PlayerProfileManager.CurrentSelectedProfile.GetCurrentLevel())
	get_node("Control/Panel/DescriptionPanelLeft/GamePlayed").text = "Games played: " + str(PlayerProfileManager.CurrentSelectedProfile.GetTotalPlayedRounds())
	get_node("Control/Panel/DescriptionPanelLeft/WinRatio").text = "Win ratio: " + str(PlayerProfileManager.CurrentSelectedProfile.GetTotalWinRatio()) + " percent"
	get_node("Control/Panel/DescriptionPanelRight/Money").text = "$" + str(PlayerProfileManager.CurrentSelectedProfile.GetCurrentMoney())

	if PlayerProfileManager.CurrentSelectedProfile.GetRoundResults().size() <= 5:
		for i in PlayerProfileManager.CurrentSelectedProfile.GetRoundResults().size():
			CreateNewLabel(PlayerProfileManager.CurrentSelectedProfile.GetRoundResults()[i])
	else:
		for i in range(PlayerProfileManager.CurrentSelectedProfile.GetRoundResults().size() - 5, PlayerProfileManager.CurrentSelectedProfile.GetRoundResults().size()):
			CreateNewLabel(PlayerProfileManager.CurrentSelectedProfile.GetRoundResults()[i])
	
func CreateNewLabel(var balance):
	var label = Label.new()
	var lastBetsContainer = get_node("Control/Panel/DescriptionPanelRight/LastBetsContainer")
	label.set("custom_fonts/font", load("res://Fonts/Pixeled_Font_Titles.tres"))
	label.set("custom_fonts/settings/size", 20)
	
	if (balance >= 0):
		label.set("custom_colors/font_color", Color(0, 1, 0))	
		label.text = "+ $" + str(balance)
	else:
		label.set("custom_colors/font_color", Color(1, 0, 0))
		label.text = "- $" + str(abs(balance))
	
	lastBetsContainer.add_child(label)

func _on_QuitButton_button_down():
	GameManager.UnloadAllChilds()
	GameManager.LoadMainMenu()
