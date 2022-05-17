extends Node2D

func _ready():
	print("connect poszedł")
	GameManager.connect("SceneChanged", self, "OnSceneChanged")

func OnSceneChanged(oldScene, newScene):
	if (newScene != "Przegrana"): return;
	
	get_node("CashLabel").set_text("+$"+str($"/root/GameManager".Bet))
	
	PlayerProfileManager.SpendMoney(GameManager.Bet)

func _process(delta):
	pass
	

func _on_BtnQuit_pressed():
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	GameManager.UnloadAllChilds()
	GameManager.PlayLevel()
