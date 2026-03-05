extends Node

var score=0

@onready var score_label = $"../CanvasLayer/ScoreLabel"

func add_point():
	score+=1
	score_label.text="energy: " + str(score)
