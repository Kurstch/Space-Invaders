# Enemy
extends KinematicBody2D

var jumpDistance = 25
var JumpsToSide
var jumps = 0

func _ready():
	$JumpTimer.wait_time = 1.2
	$JumpTimer.start()

func _on_JumpTimer_timeout():
	movement()

func movement():
	JumpsToSide = ((get_viewport().size.x / 64) - 1)
	jumps += 1
	if jumps < JumpsToSide:
		position.x += jumpDistance
	elif jumps == JumpsToSide:
		jumpDistance = -jumpDistance
		$JumpTimer.wait_time -= 0.2
		position.y += 20
		jumps = 0
