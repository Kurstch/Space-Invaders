extends KinematicBody2D

var motion

func _physics_process(_delta):
	position += motion
	if position.x < -11:
		delete_self()
	elif position.x > 780:
		delete_self()
	if $AnimatedSprite.frame == 2:
		delete_self()

func delete_self():
	queue_free()

func self_hit():
	$AnimatedSprite.play("Death")
	motion = Vector2(0,0)
