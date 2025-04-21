extends Resource

class_name CharacterSkinLibrary

@export var skins: Array[CharacterSkin]

func get_selected_idx():
	return skins.find_custom((func(skin: CharacterSkin): return skin.is_selected).bind())
