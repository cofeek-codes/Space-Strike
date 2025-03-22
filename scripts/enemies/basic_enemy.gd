extends Area2D

var speed = randf_range(100.0, 200.0)

@onready var player = get_node('../Player') 

var bullet_scene = preload("res://scenes/enemies/enemy_bullet.tscn")

@onready var aimMarker: Marker2D = $AimMarker  


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = aimMarker.global_position
	get_parent().add_child(bullet)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = position.move_toward(player.position, speed * delta)
	


func _on_shoot_cool_down_timer_timeout() -> void:
	shoot()
