extends Control

@onready var title_label: RichTextLabel = $TitleLabel
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var subtitle_label: RichTextLabel = $SubTitleLabel
@onready var play_button: TextureButton = $PlayButton
@onready var settings_button: TextureButton = $SettingsButton

@onready var camera: Camera2D = $Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# title
	var title_animation_player: AnimationPlayer = title_label.get_child(0)
	title_animation_player.play('appear')
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_title_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'appear':
		audio_player.play()
		var subtitle_animation_player: AnimationPlayer = subtitle_label.get_child(0)
		subtitle_animation_player.play('appear')
		var play_button_animation_player: AnimationPlayer = play_button.get_child(0).get_child(0)
		await get_tree().create_timer(0.5).timeout
		play_button_animation_player.play('appear')
		await get_tree().create_timer(1).timeout
		play_button_animation_player.play('pulse')
		var settings_button_animation_player: AnimationPlayer = settings_button.get_child(0).get_child(0)
		settings_button_animation_player.play('appear')


func _on_settings_button_pressed() -> void:
	camera.position.x += get_viewport_rect().size.x


func _on_play_button_pressed() -> void:
	audio_player.play()
	var subtitle_animation_player: AnimationPlayer = subtitle_label.get_child(0)
	subtitle_animation_player.play_backwards('appear')
	var play_button_animation_player: AnimationPlayer = play_button.get_child(0).get_child(0)
	await get_tree().create_timer(0.5).timeout
	play_button_animation_player.play_backwards('appear')
	var settings_button_animation_player: AnimationPlayer = settings_button.get_child(0).get_child(0)
	settings_button_animation_player.play_backwards('appear')
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")
	
