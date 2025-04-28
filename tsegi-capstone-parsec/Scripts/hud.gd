extends Control

@onready var score = $Score:
	set(value):
		score.text = "score: " + str(value)
