extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("default")
	sprite.playing = false
	sprite.frame = 0

func self_hit():
	if sprite.frame == 0:
		sprite.frame = 1
	elif sprite.frame == 1:
		sprite.frame = 2
	else:
		queue_free()
