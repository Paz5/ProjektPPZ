extends Node2D

func _ready():
	print("Wygrana: SceneChanged connect")
	GameManager.connect("SceneChanged", self, "OnSceneChanged")
	ChangeBetValue()
	

func _process(delta):
	print("+$"+str($"/root/GameManager".Bet))
	

func _on_BtnQuit_pressed():
	GameManager.Bet=0
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	GameManager.Bet=0
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	GameManager.UnloadAllChilds()
	GameManager.PlayLevel()

func ChangeBetValue():
	print("wygrałeś")
	get_node("Control/CashLabel").set_text("+$"+str(GameManager.Bet))
	#PlayerProfileManager.AddMoney(GameManager.Bet) #RoundManager już to robi
