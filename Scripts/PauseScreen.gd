extends Control

func _ready():
	if Global.player_lives == 0:
		$GameOverLabel.visible = true
		pause_game()

func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused == false:
			$PauseLabel.text = "Paused"
		pause_game()
	if Input.is_action_just_pressed("ui_shoot"):
		var score_label = get_parent().get_node("Ui/Background/TextPanel/HBoxContainer/ScoreLabel")
		if $PauseLabel.text == "Game Over \n" + str(score_label.text):
			Global.player_lives = 3
			Global.score = 0
			get_tree().reload_current_scene()


func game_over():
	var score_label = get_parent().get_node("Ui/Background/TextPanel/HBoxContainer/ScoreLabel")
	$PauseLabel.text = "Game Over \n" + str(score_label.text)
	pause_game()

func pause_game():
	get_parent().move_child(self, get_parent().get_child_count())
	if get_tree().paused == false:
		$PauseLabel.visible = true
		$PausePanel.visible = true
		get_tree().paused = true
	else:
		$PauseLabel.visible = false
		$PausePanel.visible = false
		get_tree().paused = false
