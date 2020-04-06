extends Area2D

var motion = Vector2(0, 5)

func _physics_process(_delta):
	position += motion
	if position.y > get_viewport().size.y:
		get_parent().remove_child(self)

func _on_Area2D_body_entered():
	get_parent().remove_child(self)
