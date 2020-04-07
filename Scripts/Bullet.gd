extends Area2D

var motion

func _physics_process(_delta):
	position += motion
	if position.y > get_viewport().size.y + 60:
		delete_self()
	elif position.y < -60:
		delete_self()

func _on_Area2D_body_entered(_body):
	delete_self()

func delete_self():
	get_parent().remove_child(self)