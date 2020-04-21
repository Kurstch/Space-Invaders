extends KinematicBody2D

var pointsOnKill = 60
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
	Global.score += pointsOnKill
	var ui = get_parent().get_node("Ui")
	ui.update_score_label()
	$AnimatedSprite.play("Death")
	motion = Vector2(0,0)