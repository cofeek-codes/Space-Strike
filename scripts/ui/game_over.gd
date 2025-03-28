extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var game_over_label: Label = $Panel/GameOverLabel
@onready var score_label: Label = $Panel/ScoreLabel


const PANEL_TWEEN_DURATION = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.position.y -= panel.size.y
	game_over_label.position.x -= panel.size.x
	
	var panel_tween: Tween
	var game_over_label_tween: Tween
	var score_label_tween: Tween
	var max_score_label_tween: Tween

	
	
	panel_tween = check_and_create_tween(panel_tween, Tween.TransitionType.TRANS_CUBIC)
	panel_tween.tween_property(panel, 'position:y', panel.position.y + panel.size.y, PANEL_TWEEN_DURATION)
	await get_tree().create_timer(0.5).timeout
	game_over_label_tween = check_and_create_tween(game_over_label_tween, Tween.TransitionType.TRANS_CUBIC)
	game_over_label_tween.tween_property(game_over_label, "position:x", game_over_label.position.x + panel.size.x, PANEL_TWEEN_DURATION)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_and_create_tween(tween: Tween, transition_type: Tween.TransitionType):
	if (tween == null || !tween.is_running()):
		tween = create_tween().set_trans(transition_type)
		
	return tween
