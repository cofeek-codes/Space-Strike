extends Control

@onready var camera: Camera2D = $"../Camera"

@onready var htp_label: RichTextLabel = $HowToPlayLabel

func _ready() -> void:
	htp_label.text = tr("HTP_TEXT") + "\n".repeat(5)

func _on_back_button_pressed() -> void:
	camera.position.y -= get_viewport_rect().size.y
