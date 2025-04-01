extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature('web'):
		TranslationServer.set_locale('ru')
