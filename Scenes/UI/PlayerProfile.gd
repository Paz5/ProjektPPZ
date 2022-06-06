extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func CashValue():
#	PlayerProfileManager.CurrentSelectedProfile.profileName
#	get_node("Control/CashLabel").set_text("$"+str(GameManager.Bet))
	pass
	
func _on_BtnX_pressed():
	GameManager.Bet=0
	GameManager.UnloadAllChilds()
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")
