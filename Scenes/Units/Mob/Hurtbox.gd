extends Area2D

export var entryDamage: float

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().name)
	area.get_parent().DealDamage(entryDamage)
	pass # Replace with function body.
