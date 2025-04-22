extends Node2D

@onready var yandex_ads: YandexAds = $YandexAds


func _ready() -> void:
	yandex_ads.load_banner()
