extends Node2D

var applyButton
var playerProfileInput
var profileName

func _ready():
	applyButton = get_node("ApplyButton")
	playerProfileInput = get_node("PlayerProfileInput")


func _on_LineEdit_text_changed(new_text):
		applyButton.disabled = playerProfileInput.text == ""


func _on_Button_pressed():
	profileName = playerProfileInput.text
	
	if (PlayerProfileManager.CheckProfileExist(profileName)):
		PlayerProfileManager.LoadGame(profileName)
	else:
		PlayerProfileManager.CreateNewProfile(profileName)

	GameManager.LoadMainMenu()
