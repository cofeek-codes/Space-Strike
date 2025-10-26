extends Control


signal open

@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

var music_bus_idx = AudioServer.get_bus_index("Music")
var sfx_bus_idx = AudioServer.get_bus_index("SFX")


func _ready() -> void:
	self.hide()


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_idx, value)
	Settings.sfx_volume = value
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_idx, value)
	Settings.music_volume = value


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	audio_player.play()


func _on_continue_button_pressed() -> void:
	Settings.save_settings()
	PlaygamaManager.unpause()


func _on_pause_menu_open() -> void:
	music_slider.value = Settings.music_volume
	sfx_slider.value = Settings.sfx_volume
