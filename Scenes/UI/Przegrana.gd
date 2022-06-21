extends Node2D

func _ready():
	print("Przegrana: SceneChanged connect")
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	ChangeBetValue()

func _process(delta):
	pass
	

func _on_BtnQuit_pressed():
	RoundManager.Reset()
	GameManager.Bet=0
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	RoundManager.Reset()
	GameManager.Bet=0
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	GameManager.UnloadAllChilds()
	GameManager.PlayLevel()

func ChangeBetValue():
	print("przegrałeś")
	get_node("Control/CashLabel").set_text("-$"+str(GameManager.Bet))
	#PlayerProfileManager.SpendMoney(GameManager.Bet)
 
func _on_BtnX_pressed():
	GameManager.Bet=0
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")
	
