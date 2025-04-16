extends Node2D

signal baff_spawn_requested(init_postiion: Vector2)

var buff_preloads_list = [
	preload('res://scenes/buffs/shield/shield_buff_consumable.tscn')
]


func _on_baff_spawn_requested(init_postiion: Vector2) -> void:
	var rand = randf()
	print(rand)
	if rand < 0.5:
		print('buff should be spawned')
		var current_preload = buff_preloads_list.pick_random()
		var buff_instance = current_preload.instantiate()
		buff_instance.position = init_postiion
		get_parent().call_deferred("add_child", buff_instance)
