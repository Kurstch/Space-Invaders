extends Control

func _ready():
	update_score_label()

func update_score_label():
	$Background/TextPanel/HBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)
