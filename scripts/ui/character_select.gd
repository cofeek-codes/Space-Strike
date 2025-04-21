extends Control

@onready var current_skin: TextureRect = %CurrentSkin
@onready var confirm_button: Button = %ConfirmButton
@onready var coin_icon: TextureRect = %CoinIcon

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var skinLibrary: CharacterSkinLibrary

var index: int = 0

func _ready() -> void:
	var chosen_skin_index = skinLibrary.skins.find_custom((func(skin: CharacterSkin): return skin.is_selected).bind())
	print(chosen_skin_index)
	index = chosen_skin_index
	current_skin.texture = skinLibrary.skins[index].texture
	update_selected_info(chosen_skin_index)

func _on_confirm_button_pressed() -> void:
	Globals.player_texture = current_skin.texture



func _on_prev_button_pressed() -> void:
	switch_skin(index - 1)


func _on_next_button_pressed() -> void:
	switch_skin(index + 1)
	
	
func switch_skin(new_index: int):
	var skins_count: int = len(skinLibrary.skins)
	if new_index < 0:
		index = skins_count - 1
	elif new_index > skins_count - 1:
		index = 0 
	else:
		index = new_index
		
	show_skin(index)
	update_selected_info(index)

func show_skin(index: int):
	animation_player.play_backwards("appear")
	await animation_player.animation_finished
	current_skin.texture = skinLibrary.skins[index].texture
	animation_player.play("appear")
	
func update_selected_info(index: int):
	var selected_skin: CharacterSkin = skinLibrary.skins[index]
	if ENV.is_purchases_avalable() && !selected_skin.is_purchased:
		confirm_button.text = "Buy " + str(selected_skin.price)
		coin_icon.show()
	else:
		confirm_button.text = "Select"
		coin_icon.hide()
	
	
