extends Control

@onready var camera: Camera2D = $"../Camera"


func _on_back_button_pressed() -> void:
	camera.position.y -= get_viewport_rect().size.y
