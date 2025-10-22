extends Control

@onready var title_label: Label = $TitleLabel
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var subtitle_label: Label = $SubTitleLabel
@onready var play_button: TextureButton = $PlayButton
@onready var settings_button: TextureButton = $BottomContainer/SettingsButton
@onready var camera: Camera2D = $Camera
@onready var settings_menu: Control = $SettingsMenu
@onready var htp_button: Button = $BottomContainer/HowToPlayButton
@onready var htp_container: Control = $BottomContainer

#@onready var set_locate_button: TextureButton = $SetLocateButton
#@onready var set_locate_button_sprite: Sprite2D = $SetLocateButton/Sprite




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#YandexSDK.init_game()
	Settings.load_settings()
	#YandexSDK.game_ready()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)
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
		var htp_button_animation_player: AnimationPlayer = htp_button.get_child(0)
		htp_button_animation_player.play('appear')
		var settings_button_animation_player: AnimationPlayer = settings_button.get_child(1)
		settings_button_animation_player.play('appear')


func _on_settings_button_pressed() -> void:
	settings_menu.emit_signal('open')
	camera.position.x += get_viewport_rect().size.x
	

func _on_play_button_pressed() -> void:
	audio_player.play()
	var subtitle_animation_player: AnimationPlayer = subtitle_label.get_child(0)
	subtitle_animation_player.play_backwards('appear')
	var play_button_animation_player: AnimationPlayer = play_button.get_child(0).get_child(0)
	await get_tree().create_timer(0.5).timeout
	play_button_animation_player.play_backwards('appear')
	var settings_button_animation_player: AnimationPlayer = settings_button.get_child(1)
	settings_button_animation_player.play_backwards('appear')
	get_tree().change_scene_to_file("res://scenes/main/game.tscn")
	


func _on_how_to_play_button_pressed() -> void:
	camera.position.y += get_viewport_rect().size.y
