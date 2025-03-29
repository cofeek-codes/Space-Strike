extends Area2D

var speed = randf_range(100.0, 200.0)

@onready var player = get_node('../Player/EnemyTarget')

var bullet_scene = preload("res://scenes/enemies/enemy_bullet.tscn")

@onready var aim_marker: Marker2D = $AimMarker
@onready var animation_player: AnimatedSprite2D = $AnimationPlayer
@onready var collider: CollisionPolygon2D = $Collider
@onready var explosion_particles: GPUParticles2D = $ExplosionPS
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var score: Control = $"../Score"

@onready var explosion_sfx_stream = load("res://assets/audio/sfx/explosion.wav")

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = aim_marker.global_position
	get_parent().add_child(bullet)

func die():
	if animation_player.animation != 'die':
		animation_player.play('die')
		explosion_particles.restart()
		audio_player.stream = explosion_sfx_stream
		audio_player.pitch_scale = randf_range(0.5, 1.2)
		audio_player.play()
		score.emit_signal('update_score')
		
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = position.move_toward(player.global_position, speed * delta)
	


func _on_shoot_cool_down_timer_timeout() -> void:
	shoot()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player_bullets'):
		die()
		


func _on_animation_player_animation_finished() -> void:
	if animation_player.get_animation() == 'die':
		queue_free()
