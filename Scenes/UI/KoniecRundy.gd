extends Node2D

func _ready():
	print("poszedł connect Koniec rundy")
	GameManager.connect("SceneChanged", self, "OnSceneChanged")

func OnSceneChanged(oldScene, newScene):
	if (newScene != "KoniecRundy"): return;
	
	get_node("Control/CashLabel").set_text("+$"+str($"/root/GameManager".Bet))
	
	# Mikołaj - Dodanie do profilu gracza naszą wygraną
	# Mikołaj - Todo - sprawdzenie rezultatu rundy, chyba że będzie split na scenę z przegraną i scenę z wygraną
	PlayerProfileManager.AddMoney(GameManager.Bet)
	print(oldScene)
	print(newScene)

func _process(delta):
	pass
	

func _on_BtnQuit_pressed():
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")


func _on_BtnNextRound_pressed():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	GameManager.UnloadAllChilds()
	GameManager.PlayLevel()
