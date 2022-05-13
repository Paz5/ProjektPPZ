extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	get_node("Red_Rectangle").hide()
	get_node("Blue_Rectangle").hide()
	get_node("Box").hide()
	
func _process(delta):
	if $BtnRed/BtnRedAnim.is_playing() == true:
		if $BtnRed/BtnRedAnim.get_frame() == 10 && $BtnRed/BtnRedAnim.get_animation()=="CLick":
			$BtnRed/BtnRedAnim.stop()
	elif $BtnBlue/BtnBlueAnim.is_playing() == true:
		if $BtnBlue/BtnBlueAnim.get_frame() == 10 && $BtnBlue/BtnBlueAnim.get_animation()=="CLick":
			$BtnBlue/BtnBlueAnim.stop()
	#if GameManager.SelectedTeam == "Red":
	#	$BtnBlue/BtnBlueAnim.set_animation("Hover")
	#elif GameManager.SelectedTeam == "Blue":
	#	$BtnRed/BtnRedAnim.set_animation("Hover")
		
	
		
	
func OnSceneChanged(oldScene, newScene):
	# Mikołaj - Ustawnienie wartości slidera na 0
	get_node("Box/BetSlider").value = 0

# Krystian - Wrócenie do Main Menu
func _on_Cancel_pressed():
	get_node("/root/GameManager").LoadMainMenu()

func _on_HSlider_value_changed(value):
	get_node("Box/BetLabel").set_text("$"+str(value))
	$"/root/GameManager".Bet=value



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
	
	
func _on_BtnRed_pressed():
		get_node("BetLabel_Message").hide()
		get_node("Red_Rectangle").show()
		get_node("Box").show()
		get_node("Blue_Rectangle").hide()
		GameManager.SelectedTeam = "Red"
		$BtnRed/BtnRedAnim.set_animation("CLick")
		$TeamLabel.set_text(GameManager.SelectedTeam)
		$BtnBlue/BtnBlueAnim.set_animation("Default")
		
		
func _on_BtnBlue_pressed():
		get_node("BetLabel_Message").hide()
		get_node("Blue_Rectangle").show()
		get_node("Box").show()
		get_node("Red_Rectangle").hide()
		GameManager.SelectedTeam = "Blue"
		$BtnBlue/BtnBlueAnim.set_animation("CLick")
		$TeamLabel.set_text(GameManager.SelectedTeam)
		$BtnRed/BtnRedAnim.set_animation("Default")
	
# Krystian - Jeżeli najechane na button'a pojawia się animacja koloru czerwonego
func _on_BtnRed_mouse_entered():
	if GameManager.SelectedTeam != "Red":
		$BtnRed/BtnRedAnim.set_animation("Hover")
		$BtnRed/BtnRedAnim.play()

		
# Krystian - Jeżeli nie ma myszy na buttonie usuwa sie animacja 
func _on_BtnRed_mouse_exited():
	if GameManager.SelectedTeam != "Red":
		$BtnRed/BtnRedAnim.set_animation("Default")

	pass
	
# Krystian - Jeżeli najechane na button'a pojawia się animacja koloru niebieskiego
func _on_BtnBlue_mouse_entered():
	if GameManager.SelectedTeam != "Blue":
		$BtnBlue/BtnBlueAnim.set_animation("Hover")
		$BtnBlue/BtnBlueAnim.play()
# Krystian - Jeżeli nie ma myszy na buttonie usuwa sie animacja 
func _on_BtnBlue_mouse_exited():
	if GameManager.SelectedTeam != "Blue":
		$BtnBlue/BtnBlueAnim.set_animation("Default")
