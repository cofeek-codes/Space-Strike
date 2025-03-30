extends Area2D

var speed = randf_range(100.0, 200.0)

@onready var player = get_node('../Player/EnemyTarget')

var bullet_scene = preload("res://scenes/enemies/enemy_curve_bullet.tscn")

@onready var aim_marker: Marker2D = $AimMarker
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collider: CollisionPolygon2D = $Collider
@onready var explosion_particles: GPUParticles2D = $ExplosionPS
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var score: Control = $"../Score"

@onready var explosion_sfx_stream = preload("res://assets/audio/sfx/explosion.wav")
@onready var hit_sfx_stream = preload("res://assets/audio/sfx/hit.wav")

const MAX_HEALTH = 2

var health = MAX_HEALTH


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = aim_marker.global_position
	get_parent().add_child(bullet)

func die():
	print_debug("die")
	animation_player.play('die')
	explosion_particles.restart()
	audio_player.stream = explosion_sfx_stream
	audio_player.pitch_scale = randf_range(0.5, 1.2)
	audio_player.play()
	score.emit_signal('update_score')
	await animation_player.animation_finished
	queue_free()
	
	

func get_hit():
	print_debug("get_hit")
	print("enemy health %d" % health)
	animation_player.play("hit")
	audio_player.stream = hit_sfx_stream
	audio_player.pitch_scale = randf_range(0.5, 1.2)
	audio_player.play()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug('curve enemy spawned')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !animation_player.is_playing():
			position = position.move_toward(player.global_position, speed * delta)
	


func _on_shoot_cool_down_timer_timeout() -> void:
	if !animation_player.is_playing():
		shoot()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player_bullets'):
		health -= 1
		if health == 0:
			die()
		else:
			get_hit()
