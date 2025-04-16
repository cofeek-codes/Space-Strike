extends Area2D

var speed = randf_range(100.0, 200.0)

@onready var player = get_node('../Player/EnemyTarget')

var bullet_scene = preload("res://scenes/enemies/enemy_curve_bullet.tscn")

@onready var aim_marker: Marker2D = $AimMarker
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hp_animation_player: AnimationPlayer = $HealthBar/HPAnimationPlayer
@onready var collider: CollisionPolygon2D = $Collider
@onready var explosion_particles: GPUParticles2D = $ExplosionPS
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var health_bar: ProgressBar = $HealthBar
@onready var score: Control = $"../Score"
@onready var buff_spawner: Node2D = $"../BuffSpawner"

@onready var explosion_sfx_stream = preload("res://assets/audio/sfx/explosion.wav")
@onready var hit_sfx_stream = preload("res://assets/audio/sfx/hit.wav")

const MAX_HEALTH = 2

var health = MAX_HEALTH


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = aim_marker.global_position
	get_parent().add_child(bullet)

func die():
	if animation_player.current_animation != 'die':
		#print_debug("die")
		animation_player.play('die')
		buff_spawner.emit_signal('baff_spawn_requested', self.position)
		hp_animation_player.play('reduce_and_disappear')
		explosion_particles.restart()
		audio_player.stream = explosion_sfx_stream
		audio_player.pitch_scale = randf_range(0.5, 1.2)
		audio_player.play()
		score.emit_signal('update_score', 2)
		await animation_player.animation_finished
		queue_free()
	
	
func take_damage():
	if animation_player.current_animation != 'die':
		#print_debug('take_damage')
		animation_player.play("hit")
		hp_animation_player.play('appear_and_reduce')
		audio_player.stream = hit_sfx_stream
		audio_player.pitch_scale = randf_range(0.5, 1.2)
		audio_player.play()
	
	

func get_hit():
	health -= 1
	health_bar.value = health
	if health == 0:
		die()
	else: 
		take_damage()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print_debug('curve enemy spawned')
	health_bar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !animation_player.is_playing():
			position = position.move_toward(player.global_position, speed * delta)
	


func _on_shoot_cool_down_timer_timeout() -> void:
	if !animation_player.is_playing():
		shoot()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player_bullets'):
			get_hit()
