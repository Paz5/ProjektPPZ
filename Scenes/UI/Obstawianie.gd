extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerForLabelMessage.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func _on_Cancel_pressed():
	get_tree().quit()

func _on_HSlider_value_changed(value):
	get_node("Box/BetLabel").set_text("$"+str(value))


func _on_BtnRed_pressed():
	Player = "Red"

func _on_BtnBlue_pressed():
	Player = "Blue"


func _on_Timer_timeout():
	get_node("BetLabel_Message").hide()


func _on_Confirm_pressed():
	get_tree().change_scene("res://Scenes/UI/KoniecRundy.tscn")
