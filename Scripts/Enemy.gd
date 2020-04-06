# Enemy
extends KinematicBody2D

var bodyBlocking = false
var jumpDistance = 25
var JumpsToSide
var jumps = 0

func _ready():
	JumpsToSide = ((get_viewport().size.x / 64) - 1)
	$JumpTimer.wait_time = 1.2
	$JumpTimer.start()

func _on_JumpTimer_timeout():
	movement()

func movement():
	jumps += 1	
	if jumps < JumpsToSide:
		position.x += jumpDistance		
	elif jumps == JumpsToSide:
		jumpDistance = -jumpDistance
		$JumpTimer.wait_time -= 0.2
		position.y += 20
		jumps = 0

func isBodyBlocking():
	var spaceState = get_world_2d().direct_space_state
	var sightCheck = spaceState.intersect_ray(position, Vector2(position.x, position.y + 70), [self, get_parent().get_node("Player")], collision_mask)
	if sightCheck:
		if sightCheck.collider.is_in_group("Enemy"):
			bodyBlocking = true
			print(sightCheck.collider.name)
		else:
			bodyBlocking = false
