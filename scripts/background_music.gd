extends AudioStreamPlayer

signal game_over
signal restart

var music_bus_idx = AudioServer.get_bus_index("Music")

func _on_game_over() -> void:
	#print_debug("game_over signal bgm")
	AudioServer.set_bus_effect_enabled(music_bus_idx, 0, true)
	AudioServer.set_bus_effect_enabled(music_bus_idx, 1, true)
	


func _on_restart() -> void:
	#print_debug("restart signal bgm")
	AudioServer.set_bus_effect_enabled(music_bus_idx, 0, false)
	AudioServer.set_bus_effect_enabled(music_bus_idx, 1, false)
	self.play()
