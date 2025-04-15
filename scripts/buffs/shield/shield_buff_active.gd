extends Node2D

signal deactivate_shield

@onready var player = $"../Player"
@onready var healthbar = $"../HealthBar"


@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	self.position = player.position
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	animation_player.play("appear")
	audio_player.play()
	activate()

func _physics_process(delta: float) -> void:
	self.position = player.position

func activate():
	healthbar.emit_signal('apply_shield')
	
func deactivate():
	healthbar.emit_signal('unapply_shield')
	audio_player.play()
	animation_player.play("disappear")
	audio_player.pitch_scale = 0.5
	await animation_player.animation_finished
	queue_free()
	
func _on_deactivate_shield() -> void:
	deactivate()
