extends Control

signal update_healthbar(health: int)
signal apply_shield
signal unapply_shield

@onready var hearts_container: HBoxContainer = $HeartContainer

var heart_texture = preload("res://assets/ui/game_ui/hp_heart.tres")
var broken_heart_texture = preload("res://assets/ui/game_ui/hp_heart_broken.tres")

var heart_sprites: Array[Sprite2D] = [] 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in hearts_container.get_children():
			heart_sprites.append(child.get_child(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_healthbar(health: int) -> void:
	for i in range(heart_sprites.size()):
		if i < health:
			heart_sprites[i].texture = heart_texture
		else:
			heart_sprites[i].texture = broken_heart_texture
			 


func _on_apply_shield() -> void:
	heart_sprites[heart_sprites.size()-1].modulate = Color.AQUA


func _on_unapply_shield() -> void:
	heart_sprites[heart_sprites.size()-1].modulate = Color.WHITE
