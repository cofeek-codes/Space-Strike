extends Node

const ENEMIES_FOLDER_PATH = "res://scenes/enemies/_enemies/"
const ENEMY_SPAWNED_LIMIT = 5

var enemy_scenes: Array = [
	preload("res://scenes/enemies/_enemies/basic_enemy.tscn"),
	preload("res://scenes/enemies/_enemies/curve_enemy.tscn")
]


func _ready() -> void:
	_debug_assert_all_enemies_loaded()

func _debug_assert_all_enemies_loaded():
	var enemy_dir_len = len(DirAccess.open(ENEMIES_FOLDER_PATH).get_files())
	assert(enemy_dir_len == len(enemy_scenes), "EnemySpawner: not all enemy scenes are loaded")

func _on_enemy_spawn_timer_timeout() -> void:
	if get_tree().get_node_count_in_group("enemies") < ENEMY_SPAWNED_LIMIT:		
		# print('new enemy should spawn')
		var enemy_to_spawn = enemy_scenes.pick_random()
		var enemy = enemy_to_spawn.instantiate()
		enemy.global_position.x = self.global_position.x
		enemy.global_position.y = randf_range(self.global_position.y - 90, self.global_position.y + 90)	
		get_parent().add_child(enemy)

	
