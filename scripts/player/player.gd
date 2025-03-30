extends CharacterBody2D

signal got_hit

const HORIZONTAL_SPEED = 500.0
const VERTICAL_SPEED = 300.0
const MAX_HEALTH = 3
const CAMERA_TWEEN_DURATION = 0.5

var game_over = false
var health = MAX_HEALTH

@onready var init_position = position

@onready var hit_cooldown_timer: Timer = $HitCoolDownTimer
@onready var aim_marker: Marker2D = $AimMarker
@onready var camera: Camera2D = $Camera
@onready var animation_player: AnimatedSprite2D = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer = $AudioPlayer
@onready var healthbar: Control = $"../HealthBar"
@onready var explosion_particles: GPUParticles2D = $ExplosionPS

var explosion_sfx = preload("res://assets/audio/sfx/explosion.wav")

var bullet_scene = preload("res://scenes/player/player_bullet.tscn")
var game_over_scene = preload("res://scenes/ui/game_over.tscn")
 
var camera_tween: Tween

func handle_borders():
	var viewport_dimensions = get_viewport_rect().size
	if position.x > viewport_dimensions.x || position.x < 0 || position.y < 0 || position.y > viewport_dimensions.y:
		position = init_position 

func shooting():
	
	if Input.is_action_just_pressed("shoot"):
		# print('shooted a bullet')
		
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = aim_marker.global_position

func movement():
		# horizontal movement
	var horizontal_input = Input.get_axis("move_left", "move_right")
	velocity.x = horizontal_input * HORIZONTAL_SPEED
	
	# vertical movement
	var vertical_input = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_input * VERTICAL_SPEED
	
	move_and_slide()


func die():
	game_over = true
	get_tree().paused = true
	for node in get_parent().get_children():
		if node.is_in_group("game_over_keep"):
			node.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		else:
			node.queue_free()
			
	camera.enabled = true
	
	if (camera_tween == null || !camera_tween.is_running()):
		camera_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
		camera_tween.tween_property(camera, 'zoom', Vector2(2,2), CAMERA_TWEEN_DURATION)
		
	
	for i in range(3):
		await get_tree().create_timer(1).timeout
		animation_player.play('hit')
		audio_player.stream = explosion_sfx
		audio_player.pitch_scale = randf_range(0.5, 1.5)
		audio_player.play()
		explosion_particles.restart()
		
	Globals.save_score()
		
	var game_over = game_over_scene.instantiate()
	add_child(game_over)
		
	
func is_invincible() -> bool:
	return !hit_cooldown_timer.is_stopped()
	
func _on_got_hit() -> void:
	# print('player: "got_hit" signal recieved')
	if !is_invincible():
		health -= 1
		print("current hp: %d" % health)
		if health == 0: die()
		
		healthbar.emit_signal('update_healthbar', health)
		audio_player.play()
		animation_player.play('hit')
		hit_cooldown_timer.start()
		
	 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready health %d" % health)
	camera.position = self.get_parent().position 
	Globals.load_score()

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if self.process_mode != Node.ProcessMode.PROCESS_MODE_WHEN_PAUSED:
		movement()
	handle_borders()
	if !game_over:
		shooting()
	


func _on_animation_player_animation_finished() -> void:
	if animation_player.animation == 'hit':
		animation_player.play('idle')
