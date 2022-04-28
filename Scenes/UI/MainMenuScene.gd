extends Control

func _ready():
	pass # Replace with function body.
	get_node("Obstawianie").hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Przycisk PLAY
func _on_BtnPlay_pressed():
	#Tymczasowe zmiana sceny na scene gry/wyboru 
	GameManager.LoadBetScene()

#Przycisk QUIT
func _on_BtnQuit_pressed():
	get_tree().quit()
	
