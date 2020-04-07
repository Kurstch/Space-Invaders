extends KinematicBody2D

var ableToFire = true
var motion = Vector2()
var speed = 200

func _input(_event):
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
	else:
		motion.x = 0
	if Input.is_action_pressed("ui_shoot"):
		if ableToFire == true:
			ableToFire = false
			var MainGameScript = get_parent()
			MainGameScript.player_shoot_bullet(self)
		elif ableToFire == false:
			ableToFire = null
			$CooldownTimer.wait_time = 1
			$CooldownTimer.start()
		
func _physics_process(_delta):
	position.x = clamp(position.x, 40, 1048)
	motion = move_and_slide(motion)

func _on_CooldownTimer_timeout():
	ableToFire = true

func self_hit():
	queue_free()