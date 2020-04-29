extends KinematicBody2D

var ableToFire = true
var isAlive = true
var motion = Vector2()
var speed = 200

func _input(_event):
	if isAlive and position.y > 100:
		if Input.is_action_pressed("ui_shoot"):
			if ableToFire:
				ableToFire = false
				var MainGameScript = get_parent()
				MainGameScript.player_shoot_bullet(self)
				$ShootAudio.play()
		if Input.is_action_pressed("ui_right"):
			motion.x = speed
		elif Input.is_action_pressed("ui_left"):
			motion.x = -speed
		else:
			motion.x = 0
	else:
		motion.x = 0
		
func _physics_process(_delta):
	if $AnimatedSprite.frame == 3:
		if Global.player_lives == -1:
			var pause_screen = get_parent().get_node("PauseScreen")
			pause_screen.game_over()
		else:
			get_tree().reload_current_scene()
	position.x = clamp(position.x, 40, 728)
	motion = move_and_slide(motion)

func self_hit():
	if $AnimatedSprite.animation == "Death":
		return
	$ExplosionSound.play()
	isAlive = false
	$AnimatedSprite.play("Death")
	Global.player_lives -= 1	
