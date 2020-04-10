 extends Area2D

var motion

func _physics_process(_delta):
	position += motion
	if position.y > get_viewport().size.y - 16:
		delete_self()
	elif position.y <= 80:
		reset_player_gun_cooldown()
		delete_self()	
	if position.y > 448:
		modulate = Color(0.42, 0.75, 0.18)
	elif position.y < 140:
		modulate = Color(0.67, 0.1, 0.11)
	else:
		modulate = Color(1,1,1)
	if $AnimatedSprite.frame == 2:
		queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		reset_player_gun_cooldown()
	body.self_hit()
	delete_self()

func delete_self():
	$AnimatedSprite.play("Hit")
	motion = Vector2(0,0)

func reset_player_gun_cooldown():
	var player = get_parent().get_node("Player")
	player.ableToFire = true
