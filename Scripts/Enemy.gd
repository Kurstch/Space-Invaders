extends KinematicBody2D

var bodyBlocking = false
var jumpDistance = 28
var JumpsToSide = 9
var jumpsDone = 0
var pointsOnKill

func _ready():
	$JumpTimer.wait_time = 1.2
	$JumpTimer.start()

# Movement
func _on_JumpTimer_timeout():
	movement()

func movement():
	jumpsDone += 1
	if position.y >= 416:
		var pause_screen = get_parent().get_node("PauseScreen")
		pause_screen.game_over()
	elif jumpsDone < JumpsToSide:
		position.x += jumpDistance
	elif jumpsDone >= JumpsToSide:
		jumpDistance = -jumpDistance
		if $JumpTimer.wait_time > 0.3:
			$JumpTimer.wait_time -= 0.1
		position.y += 20
		jumpsDone = 0

# Using raycast
func isBodyBlocking():
	var spaceState = get_world_2d().direct_space_state
	var sightCheck = spaceState.intersect_ray(position, Vector2(position.x, position.y + 30), [self], collision_mask)
	if sightCheck:
		if sightCheck.collider.is_in_group("Enemy"):
			bodyBlocking = true
		else:
			bodyBlocking = false

# Death
func self_hit():
	Global.score += pointsOnKill
	var ui = get_parent().get_node("Ui")	
	ui.update_score_label()
	$AnimatedSprite.play("Death")
	$JumpTimer.stop()

func _physics_process(_delta):
	if $AnimatedSprite.frame == 2:
		get_parent().call("enemy_remove_from_array", self)
		queue_free()