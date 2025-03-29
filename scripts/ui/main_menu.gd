extends Control

@onready var title_label: RichTextLabel = $TitleLabel
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var subtitle_label: RichTextLabel = $SubTitleLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# title
	var title_animation_player: AnimationPlayer = title_label.get_child(0)
	title_animation_player.play('appear')
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_title_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'appear':
		audio_player.play()
		var subtitle_animation_player: AnimationPlayer = subtitle_label.get_child(0)
		subtitle_animation_player.play('appear')
