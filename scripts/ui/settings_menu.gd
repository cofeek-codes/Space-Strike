extends Control



@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var back_button: Button = $BackButton

var sfx_bus_idx = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_sfx_slider_value_changed(value: float) -> void:
	print_debug(value)
	AudioServer.set_bus_volume_db(sfx_bus_idx, value)
	
