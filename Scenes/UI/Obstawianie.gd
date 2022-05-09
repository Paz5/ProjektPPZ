extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	get_node("Red_Rectangle").hide()
	get_node("Blue_Rectangle").hide()
	get_node("Box").hide()
	get_node("BtnBlue/Light2D").hide()

	
func OnSceneChanged(oldScene, newScene):
	# Mikołaj - Ustawnienie wartości slidera na 0
	get_node("Box/BetSlider").value = 0

# Krystian - Wrócenie do Main Menu
func _on_Cancel_pressed():
	get_node("/root/GameManager").LoadMainMenu()

func _on_HSlider_value_changed(value):
	get_node("Box/BetLabel").set_text("$"+str(value))
	$"/root/GameManager".Bet=value

func _on_BtnRed_pressed():
	get_node("BetLabel_Message").hide()
	if GameManager.SelectedTeam == "Red":
		get_node("Red_Rectangle").hide()
		GameManager.SelectedTeam = null
	else:
		get_node("Box").show()
		get_node("Red_Rectangle").show()
		GameManager.SelectedTeam = "Red"
		

func _on_BtnBlue_pressed():
	get_node("BetLabel_Message").hide()
	if GameManager.SelectedTeam == "Blue":
		get_node("Blue_Rectangle").hide()
		GameManager.SelectedTeam = null
	else:
		get_node("Box").show()
		get_node("Blue_Rectangle").show()
		GameManager.SelectedTeam = "Blue"

func _on_Timer_timeout():
	get_node("BetLabel_Message").hide()
	
	
	# Mikołaj - Ustawnienie maksymalnej wartości slidera na taką ile mamy pieniędzy
	get_node("Box/BetSlider").max_value = PlayerProfileManager.money



func _on_Confirm_pressed():
	# Mikołaj - Zablokowanie możliwości uruchomienia levelu jeśli wartość slidera wynosi 0
	if get_node("Box/BetSlider").value == 0: return
	
	# Mikołaj - Odjęcie z profilu gracza tyle ile obstawiliśmy
	PlayerProfileManager.SpendMoney(GameManager.Bet)
	
	GameManager.PlayLevel()
	

# Krystian - Jeżeli najechane na button'a pojawia się animacja koloru niebieskiego
func _on_BtnBlue_mouse_entered():
	get_node("Blue_Rectangle").show()
	pass # Replace with function body.
# Krystian - Jeżeli nie ma myszy na buttonie usuwa sie animacja 
func _on_BtnBlue_mouse_exited():
	get_node("BtnBlue/Light2D").show()
	if GameManager.SelectedTeam != "Blue":
		get_node("Blue_Rectangle").hide()
	pass # Replace with function body.
# Krystian - Jeżeli najechane na button'a pojawia się animacja koloru czerwonego
func _on_BtnRed_mouse_entered():
	get_node("Red_Rectangle").show()
# Krystian - Jeżeli nie ma myszy na buttonie usuwa sie animacja 
func _on_BtnRed_mouse_exited():
	if GameManager.SelectedTeam != "Red":
		get_node("Red_Rectangle").hide()

