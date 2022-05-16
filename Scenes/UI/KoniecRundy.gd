extends Control

func _ready():
	
	GameManager.connect("SceneChanged", self, "OnSceneChanged")

func OnSceneChanged(oldScene, newScene):
	if (newScene != "KoniecRundy"): return;
	
	get_node("CashLabel").set_text("+$"+str($"/root/GameManager".Bet))
	
	# Mikołaj - Dodanie do profilu gracza naszą wygraną
	# Mikołaj - Todo - sprawdzenie rezultatu rundy, chyba że będzie split na scenę z przegraną i scenę z wygraną
	PlayerProfileManager.AddMoney(GameManager.Bet)

func _process(delta):
	pass
	

func _on_BtnQuit_pressed():
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	GameManager.UnloadAllChilds()
	GameManager.PlayLevel()
