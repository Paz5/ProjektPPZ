extends Control

func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Przycisk PLAY
func _on_BtnPlay_pressed():
	#Tymczasowe zmiana sceny na scene gry/wyboru 
	get_tree().change_scene("res://Scenes/Root.tscn")

#Przycisk QUIT
func _on_BtnQuit_pressed():
	get_tree().quit()
	
