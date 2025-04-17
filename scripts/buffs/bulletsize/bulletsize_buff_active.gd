extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var timer: Timer = $Timer

const bullet_scale_factor: float = 2.0


func _ready() -> void:
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	audio_player.play()
	activate()

func _physics_process(delta: float) -> void:
	if !timer.is_stopped():
		for node in get_tree().get_nodes_in_group("player_bullets"):
			node.scale = Vector2(bullet_scale_factor, bullet_scale_factor)

func activate():
	timer.start()

func deactivate():
	print('bulletsize buff deactivated')
	for node in get_tree().get_nodes_in_group("player_bullets"):
		node.scale = Vector2.ONE


func _on_timer_timeout() -> void:
	print('bulletsize buff timedout')
	deactivate()
