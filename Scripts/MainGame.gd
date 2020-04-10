extends Node2D

var bulletScene = preload("res://Scenes/Bullet.tscn")
var enemyScene = preload("res://Scenes/Enemy.tscn")
var playerScene = preload("res://Scenes/Player.tscn")
var redEnemyScene = preload("res://Scenes/RedEnemy.tscn")
var enemyArray = []
var rows = 5
var collumns = 10

func _ready():
	InitializePlayer()
	InitializeEnemies()
	InitializeBulletTimer()
	InitializeRedEnemyTimer()

func InitializePlayer():
	var player = playerScene.instance()
	add_child(player)
	player.get_child(0).play("default")
	player.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y - 40)
	player.scale = Vector2(4,4)

func InitializeEnemies():
	for row in rows:
		for collumn in collumns:
			var enemy = enemyScene.instance()
			var spawnLocation = Vector2((36 + (36 * collumn) + (16 * collumn)),(140 + (24 * row) + (16 * row)))
			add_child(enemy)
			enemy.position = spawnLocation
			if enemy.position.y < 142:
				enemy.get_child(0).play("Enemy3")
			elif enemy.position.y > 142 and enemy.position.y < 222:
				enemy.get_child(0).play("Enemy2")
			else:
				enemy.get_child(0).play("Enemy1")
			enemy.scale = Vector2(3,3)
			enemyArray.insert(enemyArray.size(), enemy)

func InitializeBulletTimer():
	$BulletTimer.wait_time = 0.2
	$BulletTimer.start()

func InitializeRedEnemyTimer():
	$RedEnemyCooldown.wait_time = 3
	$RedEnemyCooldown.start()

func _on_BulletTimer_timeout():
	chance_to_spawn_bullet()
		
func chance_to_spawn_bullet():
	var enemy = enemyArray[int(rand_range(0, enemyArray.size() -1))]
	enemy.isBodyBlocking()
	if enemy.bodyBlocking == false:
		enemy_shoot_bullet(enemy)

func enemy_shoot_bullet(var enemy):
	var bullet = bulletScene.instance()
	var spawnLocation = Vector2((enemy.position.x),(enemy.position.y + 30))	
	add_child(bullet)
	var bulletType = "Bullet" + str(int(rand_range(1,3)))
	bullet.get_child(0).play(bulletType)
	bullet.position = spawnLocation
	bullet.motion = Vector2(0, 5)
	bullet.scale = Vector2(4, 4)
 
func player_shoot_bullet(var player):
	var bullet = bulletScene.instance()
	var spawnLocation = Vector2((player.position.x), (player.position.y - 30))
	add_child(bullet)
	bullet.get_child(0).play("BulletPlayer")
	bullet.position = spawnLocation
	bullet.motion = Vector2(0, -15)
	bullet.scale = Vector2(4, 4)

func enemy_remove_from_array(enemy):
	enemyArray.remove(enemyArray.find(enemy))
	enemyArray.sort()

func _on_RedEnemyCooldown_timeout():
	spawn_red_enemy()

func spawn_red_enemy():
	if int(rand_range(0,5)) <= 2:
		var enemy = redEnemyScene.instance()
		var spawnLocation
		add_child(enemy)
		if int(rand_range(1,2)) == 1:
			spawnLocation = Vector2(-10, 96)
			enemy.motion = Vector2(5,0)
		else:
			spawnLocation = Vector2(778, 96)
			enemy.motion = Vector2(-5,0)
		enemy.get_child(0).play("default")
		enemy.position = spawnLocation
		enemy.scale = Vector2(3,3)
