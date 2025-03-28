extends Area2D


const SPEED = 300.0
const LIFETIME = 5

@onready var timer: Timer = $DispawnTimer
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

@onready var player: CharacterBody2D = get_node('../Player')

func _ready() -> void:
	audio_player.pitch_scale = randf_range(0.5, 1.5)
	audio_player.play()


func _physics_process(delta: float) -> void:
	# print("in bullet")

	position += transform.x * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemies'):
		print('bullet: area entered')
		print(area)
		queue_free()


func _on_dispawn_timer_timeout() -> void:
		print('bullet dispawned after %d seconds' % timer.wait_time)
		queue_free()
