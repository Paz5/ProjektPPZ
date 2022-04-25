extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CashLabel").set_text("+$"+str($"/root/GameManager".Bet))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_BtnNextRound_pressed():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")