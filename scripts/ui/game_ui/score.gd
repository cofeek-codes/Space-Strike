extends Control

signal update_score(score: int)
signal reset_score()

@onready var score_label: Label = $ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_score(score: int) -> void:
	Globals.score += score
	score_label.text = str(Globals.score)
	


func _on_reset_score() -> void:
	Globals.score = 0
