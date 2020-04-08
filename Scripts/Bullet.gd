extends Area2D

var motion

func _physics_process(_delta):
	position += motion
	if position.y > get_viewport().size.y + 60:
		delete_self()
	elif position.y < -60:
		reset_player_gun_cooldown()
		delete_self()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		reset_player_gun_cooldown()
	body.self_hit()
	delete_self()

func delete_self():
	queue_free()

func reset_player_gun_cooldown():
	var player = get_parent().get_node("Player")
	player.ableToFire = true
