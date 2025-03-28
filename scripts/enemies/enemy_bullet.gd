extends Area2D


const SPEED = 300.0
const LIFETIME = 5

@onready var timer: Timer = $DispawnTimer
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

@onready var player: CharacterBody2D = get_node('../Player')

func _physics_process(delta: float) -> void:
	
	position -= transform.x * SPEED * delta


func _ready() -> void:
	audio_player.pitch_scale = randf_range(0.5, 1.5)
	audio_player.play()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print('bullet: player hit')
		player.emit_signal('got_hit')
		print(body)
		queue_free()



func _on_dispawn_timer_timeout() -> void:
		print('enemy bullet dispawned after %d seconds' % timer.wait_time)
		queue_free()
