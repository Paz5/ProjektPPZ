extends Control

var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	
	$TimerForLabelMessage.start()
	get_node("Box").hide()
	
	
func OnSceneChanged(oldScene, newScene):
	# Mikołaj - Ustawnienie wartości slidera na 0
	get_node("Box/BetSlider").value = 0

func _on_Cancel_pressed():
	get_tree().quit()

func _on_HSlider_value_changed(value):
	get_node("Box/BetLabel").set_text("$"+str(value))
	$"/root/GameManager".Bet=value

func _on_BtnRed_pressed():
	Player = "Red"

func _on_BtnBlue_pressed():
	Player = "Blue"


func _on_Timer_timeout():
	get_node("BetLabel_Message").hide()
	get_node("Box").show()
	
	# Mikołaj - Ustawnienie maksymalnej wartości slidera na taką ile mamy pieniędzy
	get_node("Box/BetSlider").max_value = PlayerProfileManager.money


func _on_Confirm_pressed():
	# Mikołaj - Zablokowanie możliwości uruchomienia levelu jeśli wartość slidera wynosi 0
	if get_node("Box/BetSlider").value == 0: return
	
	# Mikołaj - Odjęcie z profilu gracza tyle ile obstawiliśmy
	PlayerProfileManager.SpendMoney(GameManager.Bet)
	
	GameManager.LoadEndRoundScene()
	
