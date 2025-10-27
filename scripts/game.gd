extends Node2D

@onready var yandex_ads: YandexAds = $YandexAds


func _ready() -> void:
	yandex_ads.load_banner()
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_pause"):
		PlaygamaManager.pause()
			
			


func _on_pause_button_pressed() -> void:
	PlaygamaManager.pause()
	
