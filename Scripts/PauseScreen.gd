extends CanvasLayer

func _ready():
	if Global.game_started == false:
		$IntroBackground.visible = true
		pause_game()
	if Global.player_lives == -1:
		$PauseLabel.visible = true
		pause_game()
	update_high_score_label()

func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused == false:
			$PauseLabel.text = "Paused"
		pause_game()
	if Input.is_action_just_pressed("ui_restart"):
		var score_label = get_parent().get_node("Ui/Background/TextPanel/HBoxContainer/ScoreLabel")
		if $PauseLabel.text == "Game Over\n" + score_label.text + "\n\n\nTo try again press R":
			reset_game()
		elif $PauseLabel.text == "Game Over\n" + score_label.text + "\nNew high score!" + "\n\nTo try again press R":
			reset_game()
		if $IntroBackground.visible == true:
			$IntroBackground.visible = false
			Global.game_started = true
			pause_game()

func reset_game():
	Global.player_lives = 3
	Global.score = 0
	get_tree().reload_current_scene()
	get_tree().paused = false

func game_over():
	var score_label = get_parent().get_node("Ui/Background/TextPanel/HBoxContainer/ScoreLabel")
	if Global.score > Global.high_score:
		$PauseLabel.text = "Game Over\n" + score_label.text + "\nNew high score!" + "\n\nTo try again press R"
		Global.high_score = Global.score
		get_parent().save_high_score()
	else:
		$PauseLabel.text = "Game Over\n" + score_label.text + "\n\n\nTo try again press R"
	pause_game()

func pause_game():
	if get_tree().paused == false:
		$PauseLabel.visible = true
		$PausePanel.visible = true
		get_tree().paused = true
	else:
		$PauseLabel.visible = false
		$PausePanel.visible = false
		get_tree().paused = false

func update_high_score_label():
	get_parent().load_high_score()
	$IntroBackground/TextPanel/HScoreLabelBottom.text = "High Score: " + str(Global.high_score)
