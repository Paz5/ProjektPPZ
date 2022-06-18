extends Control

func _ready():
	var index = 1
	var saveFiles = PlayerProfileManager.GetAllSaveProfiles()
	for file in saveFiles:
		var profilePanel = load("res://Scenes/UI/ProfilePanel.tscn")
		var instance = profilePanel.instance()
		var profileName = file.split(".")[0]
		
		get_node("Leaderboard/LeaderboardContainer").add_child(instance)
		
		var saveData = PlayerProfileManager.LoadDataFromSave(profileName)
		var fakeProfile = PlayerProfile.new(" ")

		instance.Init(str(index), profileName, saveData["Level"], fakeProfile.UpdateVariableFromSaveData(saveData, "TotalWinRatio", 0))
		
		index += 1

func _on_BtnQuit_button_down():
	GameManager.LoadMainMenu()
