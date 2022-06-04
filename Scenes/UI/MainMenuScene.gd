extends Control

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Przycisk PLAY
func _on_BtnPlay_pressed():
	#Tymczasowe zmiana sceny na scene gry/wyboru 
	GameManager.LoadBetScene()
	GameManager.PlayLevel()

func _on_BtnLeaderboard_pressed():
#	GameManager.UnloadAllChilds()
#	get_tree().change_scene("res://Scenes/UI/Leaderboard.tscn")
	pass

# Wyjście z gry
func _on_BtnQuit_pressed():
	get_tree().quit()
