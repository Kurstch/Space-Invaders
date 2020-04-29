extends Control

func _ready():
	update_score_label()
	update_high_score_label()

func update_score_label():
	$Background/TextPanel/HBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)

func update_high_score_label():
	get_parent().load_high_score()
	$Background/TextPanel/HBoxContainer/HScoreLabelTop.text = "High Score: " + str(Global.high_score)
