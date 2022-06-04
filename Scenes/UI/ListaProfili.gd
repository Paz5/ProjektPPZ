extends Control

func _ready():
	print("ListaProfili: SceneChanged connect")
	GameManager.connect("SceneChanged", self, "OnSceneChanged")

func _on_BtnChoose_pressed():
	pass # Replace with function body.

func _on_BtnAdd_pressed():
	pass # Replace with function body.

func _on_BtnDelete_pressed():
	pass # Replace with function body.

func _on_BtnX_pressed():
	GameManager.Bet=0
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")
