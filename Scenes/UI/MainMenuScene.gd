extends Control

var playerProfileNameLabel;

func _ready():
	playerProfileNameLabel = get_node("PlayerProfileNameLabel")
	playerProfileNameLabel.text = "Witaj " + PlayerProfileManager.CurrentSelectedProfile.profileName

#Przycisk PLAY
func _on_BtnPlay_pressed():
	#Tymczasowe zmiana sceny na scene gry/wyboru 
	GameManager.LoadBetScene()
	GameManager.PlayLevel()

# Przycisk LEADERBOARD
func _on_BtnLeaderboard_pressed():
#	GameManager.UnloadAllChilds()
#	get_tree().change_scene("res://Scenes/UI/Leaderboard.tscn")
	pass

# Przycisk PLAYER PROFILE
func _on_BtnPlayerProfile_button_down():
	GameManager.LoadPlayerProfile()

# Wyjście z gry
func _on_BtnQuit_pressed():
	get_tree().quit()


