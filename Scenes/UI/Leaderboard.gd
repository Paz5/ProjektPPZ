extends Control

var saveDatas: Array
var saveDatasSorted: Array

func _ready():
	var index = 1
	var saveFiles = PlayerProfileManager.GetAllSaveProfiles()

	
	var arrayIndex = 0
	
	for file in saveFiles:
		var profilePanel = load("res://Scenes/UI/ProfilePanel.tscn")
		var instance = profilePanel.instance()
		var profileName = file.split(".")[0]
		
		saveDatas.resize(saveDatas.size() + 2)
		saveDatas[arrayIndex] = profileName
		saveDatas[arrayIndex + 1] = PlayerProfileManager.LoadDataFromSave(profileName)
		
		arrayIndex += 2
	
	Sort();
	
	for i in range(0, saveDatas.size(), 2):
		var profilePanel = load("res://Scenes/UI/ProfilePanel.tscn")
		var instance = profilePanel.instance()
		var profileName = saveDatas[i].split(".")[0]
		
		get_node("Leaderboard/ScrollContainer/LeaderboardContainer").add_child(instance)
		
		var saveData = PlayerProfileManager.LoadDataFromSave(profileName)
		var fakeProfile = PlayerProfile.new(" ")

		instance.Init(str(index), profileName, saveData["Level"], int(fakeProfile.UpdateVariableFromSaveData(saveData, "TotalWinRatio", 0)))
		
		index += 1

func Sort():
	for i in range(1, saveDatas.size(), 2):
		for j in range(1, saveDatas.size() - 1, 2):
			if(saveDatas[j]["TotalWinRatio"] < saveDatas[j + 2]["TotalWinRatio"]):
				var temp1 = saveDatas[j + 2]
				var temp2 = saveDatas[j + 1]
				
				saveDatas[j + 2] = saveDatas[j]
				saveDatas[j + 1] = saveDatas[j - 1]
				
				saveDatas[j] = temp1
				saveDatas[j - 1] = temp2
		
	saveDatasSorted = saveDatas

func _on_BtnQuit_button_down():
	GameManager.LoadMainMenu()
