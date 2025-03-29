extends Control

signal open

@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var back_button: Button = $BackButton
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var camera: Camera2D = $"../Camera"

var music_bus_idx = AudioServer.get_bus_index("Music")
var sfx_bus_idx = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_idx, value)
	Settings.sfx_volume = value
	


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	audio_player.play()


func _on_back_button_pressed() -> void:
	Settings.save_settings()
	camera.position.x -= get_viewport_rect().size.x


func _on_settings_menu_open() -> void:
	music_slider.value = Settings.music_volume
	sfx_slider.value = Settings.sfx_volume
