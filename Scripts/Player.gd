# Player
extends KinematicBody2D

var motion = Vector2()
var speed = 200

func _input(_event):
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
	else:
		motion.x = 0
		
func _physics_process(_delta):
	position.x = clamp(position.x, 40, 1048)
	motion = move_and_slide(motion)
