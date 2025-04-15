extends Node2D

@onready var player = $"../Player"

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
	self.add_to_group('active_buffs')
