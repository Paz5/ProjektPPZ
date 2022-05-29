extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	var hs = $Panel/ScrollContainer/Highscore
	var new = hs.get_node("Entity").duplicate()
	
	hs.add_child(new)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
