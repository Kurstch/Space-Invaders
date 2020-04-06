# Main Script
extends Node2D

var bulletScene = preload("res://Scenes/Bullet.tscn")
var enemyScene = preload("res://Scenes/Enemy.tscn")
var playercene = preload("res://Scenes/Player.tscn")

var rows = 4
var collumns = 6
	
#spawn player first	
func _ready():
	var player = playercene.instance()
	add_child(player)
	player.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y - 40)
	
	for row in rows:
		for collumn in collumns:
			var enemy = enemyScene.instance()
			var spawnLocation = Vector2((64 + (64 * collumn) + (10 * collumn)),(64 + (64 * row) + (10 * row)))
			add_child(enemy)
			enemy.scale.x = 0.8
			enemy.scale.y = 0.8
			enemy.position = spawnLocation
			enemy.name = str(collumns * row + collumn)
			
	$BulletTimer.wait_time = 0.6
	$BulletTimer.start()

func _on_BulletTimer_timeout():
	chance_to_spawn_bullet()
		
func chance_to_spawn_bullet():
	var randEnemy = int(round(rand_range(3, 26)))
	var enemy = get_child(randEnemy)
	enemy.isBodyBlocking()
	if rand_range(0, 6) < 7 and enemy.bodyBlocking == false:
			shoot_bullet(enemy)
		
func shoot_bullet(var enemy):
	var bullet = bulletScene.instance()
	var spawnLocation = Vector2((enemy.position.x),(enemy.position.y + 60))	
	add_child(bullet)
	bullet.position = spawnLocation
	bullet.scale.x = 0.6
	bullet.scale.y = 0.6
