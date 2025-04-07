extends Control

@onready var camera: Camera2D = $"../Camera"

@onready var htp_label: RichTextLabel = $HowToPlayLabel

func _ready() -> void:
	pass

func _on_back_button_pressed() -> void:
	camera.position.y -= get_viewport_rect().size.y
