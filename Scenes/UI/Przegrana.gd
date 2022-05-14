extends Control

func _ready():
	
	GameManager.connect("SceneChanged", self, "OnSceneChanged")

func OnSceneChanged(oldScene, newScene):
	if (newScene != "Przegrana"): return;
	
	get_node("CashLabel").set_text("+$"+str($"/root/GameManager".Bet))
	
	PlayerProfileManager.SpendMoney(GameManager.Bet)

func _process(delta):
	pass
	

func _on_BtnQuit_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
