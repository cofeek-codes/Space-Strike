extends Area2D


const BUFF_SPAWN_DISTANCE = 300

@onready var player: CharacterBody2D = $"../Player"
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

var bulletsize_buff_active_scene_preload = preload("res://scenes/buffs/bulletsize/bulletsize_buff_active.tscn")

func _ready() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:x", self.position.x - BUFF_SPAWN_DISTANCE, 1)



func activate():
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	self.visible = false
	audio_player.play()
	var bulletsize_buff_active = bulletsize_buff_active_scene_preload.instantiate()
	get_parent().add_child(bulletsize_buff_active)
	await audio_player.finished
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		activate()
