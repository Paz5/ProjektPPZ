extends Node2D

#Krystian - włączanie i wyłączanie odpowiednich scen przy wejściu w scene "Obstawianie"
func _ready():
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	get_node("Control/Red_Rectangle").hide()
	get_node("Control/Blue_Rectangle").hide()
	get_node("Control/Box").hide()
	
#Krystian - mechanika która zatrzymuje animacje "CLick" na ostatniej klatce
func _process(delta):
	if $Control/BtnRed/BtnRedAnim.is_playing() == true:
		if $Control/BtnRed/BtnRedAnim.get_frame() == 10 && $Control/BtnRed/BtnRedAnim.get_animation()=="CLick":
			$Control/BtnRed/BtnRedAnim.stop()
	elif $Control/BtnBlue/BtnBlueAnim.is_playing() == true:
		if $Control/BtnBlue/BtnBlueAnim.get_frame() == 10 && $Control/BtnBlue/BtnBlueAnim.get_animation()=="CLick":
			$Control/BtnBlue/BtnBlueAnim.stop()
	if $Control/BtnBlue.is_disabled() == true && $Control/BtnRed.is_disabled() == true:
		pass
	
func OnSceneChanged(oldScene, newScene):
	# Mikołaj - Ustawnienie wartości slidera na 0
	get_node("Control/Box/BetSlider").value = 0
	
	# Mikołaj - Załadowanie sceny z levelem w tle
	#GameManager.PlayLevel()   - Maciej to usunął i jest git

# Krystian - Wrócenie  wyłączenie boxa z bettem - wybieranie drużyn
func _on_Cancel_pressed():
	#Main menu nie aktywne
	#get_node("/root/GameManager").LoadMainMenu()
	$Control/BtnRed.set_disabled(false)
	$Control/BtnBlue.set_disabled(false)
	$Control/Box.hide()
	GameManager.SelectedTeam = ""

func _on_HSlider_value_changed(value):
	get_node("Control/Box/BetLabel").set_text("$"+str(value))
	$"/root/GameManager".Bet=value



func _on_Timer_timeout():
	get_node("Control/BetLabel_Message").hide()
	
	
	# Mikołaj - Ustawnienie maksymalnej wartości slidera na taką ile mamy pieniędzy
	get_node("Control/Box/BetSlider").max_value = PlayerProfileManager.money



func _on_Confirm_pressed():
	# Mikołaj - Zablokowanie możliwości uruchomienia levelu jeśli wartość slidera wynosi 0
	if get_node("Control/Box/BetSlider").value == 0: return
	
	print(GameManager.Bet)
	
	# Mikołaj - Odjęcie z profilu gracza tyle ile obstawiliśmy
	PlayerProfileManager.SpendMoney(GameManager.Bet)
	
	# Mikołaj - Wyładowanie sceny MainMenu + emit signal
	var obstawianieScene = get_tree().get_root().get_node("Obstawianie")
	obstawianieScene.queue_free()
	
	RoundManager.PrepareLevel()
	GameManager.OnBetConfirmed()

	
#Krystian - obsługa czerwonego guzika - Pressed
func _on_BtnRed_pressed():
		get_node("Control/BetLabel_Message").hide()
		get_node("Control/Red_Rectangle").show()
		get_node("Control/Box").show()
		get_node("Control/Blue_Rectangle").hide()
		GameManager.SelectedTeam = "Red"
		GameManager.SelectedTeamIndex = 1;
		$Control/BtnRed/BtnRedAnim.set_animation("CLick")
		$Control/BtnBlue/BtnBlueAnim.set_animation("Default")
		$Control/BtnBlue.set_disabled(true)
		$Control/BtnRed.set_disabled(true)
		
#Krystian - obsługa niebieskiego guzika - Pressed
func _on_BtnBlue_pressed():
		get_node("Control/BetLabel_Message").hide()
		get_node("Control/Blue_Rectangle").show()
		get_node("Control/Box").show()
		get_node("Control/Red_Rectangle").hide()
		GameManager.SelectedTeam = "Blue"
		GameManager.SelectedTeamIndex = 0;
		$Control/BtnBlue/BtnBlueAnim.set_animation("CLick")
		$Control/BtnRed/BtnRedAnim.set_animation("Default")
		$Control/BtnBlue.set_disabled(true)
		$Control/BtnRed.set_disabled(true) 
		
# Krystian - Jeżeli najechane na button'a Czerwony - Hover
func _on_BtnRed_mouse_entered():
	if GameManager.SelectedTeam != "Red" && $Control/BtnRed/BtnRedAnim.get_animation() != "CLick":
		$Control/BtnRed/BtnRedAnim.set_animation("Hover")
		$Control/BtnRed/BtnRedAnim.play()
	if $Control/BtnBlue.is_disabled() == true && $Control/BtnRed.is_disabled() == true:
		$Control/BtnRed/BtnRedAnim.set_frame(10)
	
# Krystian - Jeżeli kursor wychodzi z powierzcni buttona
func _on_BtnRed_mouse_exited():
	if GameManager.SelectedTeam != "Red" && $Control/BtnRed/BtnRedAnim.get_animation() != "CLick":
		$Control/BtnRed/BtnRedAnim.set_animation("Default")
	
# Krystian - Jeżeli najechane na button'a Niebieski - Hover
func _on_BtnBlue_mouse_entered():
	if GameManager.SelectedTeam != "Blue" && $Control/BtnBlue/BtnBlueAnim.get_animation() != "CLick":
		$Control/BtnBlue/BtnBlueAnim.set_animation("Hover")
		$Control/BtnBlue/BtnBlueAnim.play()
	if $Control/BtnBlue.is_disabled() == true && $Control/BtnRed.is_disabled() == true:
		$Control/BtnBlue/BtnBlueAnim.set_frame(10)	
	
# Krystian - Jeżeli kursor wychodzi z powierzcni buttona
func _on_BtnBlue_mouse_exited():
	if GameManager.SelectedTeam != "Blue" && $Control/BtnBlue/BtnBlueAnim.get_animation() != "CLick":
		$Control/BtnBlue/BtnBlueAnim.set_animation("Default")
