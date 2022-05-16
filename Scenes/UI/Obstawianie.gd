extends Control

#Krystian - włączanie i wyłączanie odpowiednich scen przy wejściu w scene "Obstawianie"
func _ready():
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	get_node("Red_Rectangle").hide()
	get_node("Blue_Rectangle").hide()
	get_node("Box").hide()
	
#Krystian - mechanika która zatrzymuje animacje "CLick" na ostatniej klatce
func _process(delta):
	if $BtnRed/BtnRedAnim.is_playing() == true:
		if $BtnRed/BtnRedAnim.get_frame() == 10 && $BtnRed/BtnRedAnim.get_animation()=="CLick":
			$BtnRed/BtnRedAnim.stop()
	elif $BtnBlue/BtnBlueAnim.is_playing() == true:
		if $BtnBlue/BtnBlueAnim.get_frame() == 10 && $BtnBlue/BtnBlueAnim.get_animation()=="CLick":
			$BtnBlue/BtnBlueAnim.stop()
	if $BtnBlue.is_disabled() == true && $BtnRed.is_disabled() == true:
		pass
	
func OnSceneChanged(oldScene, newScene):
	# Mikołaj - Ustawnienie wartości slidera na 0
	get_node("Box/BetSlider").value = 0
	
	# Mikołaj - Załadowanie sceny z levelem w tle
	GameManager.PlayLevel()

# Krystian - Wrócenie  wyłączenie boxa z bettem - wybieranie drużyn
func _on_Cancel_pressed():
	#Main menu nie aktywne
	#get_node("/root/GameManager").LoadMainMenu()
	$BtnRed.set_disabled(false)
	$BtnBlue.set_disabled(false)
	$Box.hide()
	GameManager.SelectedTeam = ""

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
	
	# Mikołaj - Wyładowanie sceny MainMenu + emit signal
	var obstawianieScene = get_tree().get_root().get_node("Obstawianie")
	obstawianieScene.queue_free()
	
	RoundManager.PrepareLevel()
	GameManager.OnBetConfirmed()

	
#Krystian - obsługa czerwonego guzika - Pressed
func _on_BtnRed_pressed():
		get_node("BetLabel_Message").hide()
		get_node("Red_Rectangle").show()
		get_node("Box").show()
		get_node("Blue_Rectangle").hide()
		GameManager.SelectedTeam = "Red"
		GameManager.SelectedTeamIndex = 1;
		$BtnRed/BtnRedAnim.set_animation("CLick")
		$BtnBlue/BtnBlueAnim.set_animation("Default")
		$BtnBlue.set_disabled(true)
		$BtnRed.set_disabled(true)
		
#Krystian - obsługa niebieskiego guzika - Pressed
func _on_BtnBlue_pressed():
		get_node("BetLabel_Message").hide()
		get_node("Blue_Rectangle").show()
		get_node("Box").show()
		get_node("Red_Rectangle").hide()
		GameManager.SelectedTeam = "Blue"
		GameManager.SelectedTeamIndex = 0;
		$BtnBlue/BtnBlueAnim.set_animation("CLick")
		$BtnRed/BtnRedAnim.set_animation("Default")
		$BtnBlue.set_disabled(true)
		$BtnRed.set_disabled(true) 
		
# Krystian - Jeżeli najechane na button'a Czerwony - Hover
func _on_BtnRed_mouse_entered():
	if GameManager.SelectedTeam != "Red" && $BtnRed/BtnRedAnim.get_animation() != "CLick":
		$BtnRed/BtnRedAnim.set_animation("Hover")
		$BtnRed/BtnRedAnim.play()
	if $BtnBlue.is_disabled() == true && $BtnRed.is_disabled() == true:
		$BtnRed/BtnRedAnim.set_frame(10)
	
# Krystian - Jeżeli kursor wychodzi z powierzcni buttona
func _on_BtnRed_mouse_exited():
	if GameManager.SelectedTeam != "Red" && $BtnRed/BtnRedAnim.get_animation() != "CLick":
		$BtnRed/BtnRedAnim.set_animation("Default")
	
# Krystian - Jeżeli najechane na button'a Niebieski - Hover
func _on_BtnBlue_mouse_entered():
	if GameManager.SelectedTeam != "Blue" && $BtnBlue/BtnBlueAnim.get_animation() != "CLick":
		$BtnBlue/BtnBlueAnim.set_animation("Hover")
		$BtnBlue/BtnBlueAnim.play()
	if $BtnBlue.is_disabled() == true && $BtnRed.is_disabled() == true:
		$BtnBlue/BtnBlueAnim.set_frame(10)	
	
# Krystian - Jeżeli kursor wychodzi z powierzcni buttona
func _on_BtnBlue_mouse_exited():
	if GameManager.SelectedTeam != "Blue" && $BtnBlue/BtnBlueAnim.get_animation() != "CLick":
		$BtnBlue/BtnBlueAnim.set_animation("Default")
