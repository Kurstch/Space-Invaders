extends KinematicBody2D

var pointsOnKill = 60
var motion

func _ready():
	$MoveAudio.play()

func _physics_process(_delta):
	position += motion
	if position.x < -11:
		queue_free()
	elif position.x > 780:
		queue_free()
	if $AnimatedSprite.frame == 2:
		queue_free()

func self_hit():
	Global.score += pointsOnKill
	var ui = get_parent().get_node("Ui")
	ui.update_score_label()
	$AnimatedSprite.play("Death")
	motion = Vector2(0,0)
	$ExplosionAudio.play()
