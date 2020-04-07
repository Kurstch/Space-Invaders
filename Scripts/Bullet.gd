extends Area2D

var motion

func _physics_process(_delta):
	position += motion
	if position.y > get_viewport().size.y + 60:
		delete_self()
	elif position.y < -60:
		delete_self()

func _on_Area2D_body_entered(body):
	check_body(body)
	delete_self()

func check_body(var body):
	body.self_hit()

func delete_self():
	queue_free()
