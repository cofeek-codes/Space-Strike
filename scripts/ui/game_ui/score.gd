extends Control

signal update_score

@onready var score_label: Label = $ScoreLabel

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_score() -> void:
	score += 1
	score_label.text = str(score)
