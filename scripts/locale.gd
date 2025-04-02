extends Node

class_name Locale

static var ru_flag_texture = preload("res://assets/ui/main_menu/ru_flag.png")
static var en_flag_texture = preload("res://assets/ui/main_menu/en_flag.png")


static func init_locate(sprite: Sprite2D):
	var locale = OS.get_locale_language()
	
	if locale == 'en':
		sprite.texture = ru_flag_texture
	elif locale == 'ru':
		sprite.texture = en_flag_texture


static func change_locale(sprite: Sprite2D):
	var locale = OS.get_locale_language()
	print(locale)
	if locale == 'en':
		sprite.texture = en_flag_texture
		TranslationServer.set_locale('ru')
	elif locale == 'ru':
		sprite.texture = ru_flag_texture
		TranslationServer.set_locale('en')
