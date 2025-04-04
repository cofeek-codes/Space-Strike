extends Control

signal update_score(score: int)


@onready var score_label: Label = $ScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.score = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_score(score: int) -> void:
	Globals.score += score
	score_label.text = str(Globals.score)
	
