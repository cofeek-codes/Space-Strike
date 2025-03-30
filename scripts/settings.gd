extends Node

class_name Settings

static var music_volume: float = 0.0
static var sfx_volume: float = 0.0

const SETTINGS_FILE_PATH = "user://settings.dat"

static func load_settings():
	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.READ)
	if !file: return
	var data = file.get_var()
	music_volume = data["music_volume"] if data['music_volume'] else 0.0
	sfx_volume = data["sfx_volume"] if data['sfx_volume'] else 0.0
	file.close()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_volume)
	
static func save_settings():
	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.WRITE)
	# print_debug(file)
	if !file: return
	var data = {
		"music_volume": music_volume,
		"sfx_volume": sfx_volume
	}
	file.store_var(data)
	file.close()
