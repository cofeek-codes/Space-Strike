extends Node

class_name Globals

static var score: int = 0
static var high_score: int = 0


const SAVE_FILE_PATH = "user://save.dat"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

static func load_score():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if (!file): return
	var data = file.get_var()
	high_score = data['high_score'] if data['high_score'] else 0
	file.close()

static func save_score():
	if score > high_score:
		high_score = score
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
		if (!file): return
		var data = {
			"high_score": high_score
		}
		file.store_var(data)
		file.close()
	
		
		
