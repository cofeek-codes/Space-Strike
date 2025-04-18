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
@onready var score: Control = $"../Score"


var explosion_sfx = preload("res://assets/audio/sfx/explosion.wav")

var bullet_scene = preload("res://scenes/player/player_bullet.tscn")
var game_over_scene = preload("res://scenes/ui/game_over.tscn")
 
var camera_tween: Tween

func handle_borders():
	if !healthbar: return
	var viewport_dimensions = get_viewport_rect().size
	if position.x > viewport_dimensions.x || position.x < 0 || position.y < healthbar.position.y + 30 || position.y > viewport_dimensions.y:
		position = init_position 

func shoot():
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
	get_tree().get_first_node_in_group("bg_music_player").emit_signal('game_over')
	
func is_invincible() -> bool:
	return !hit_cooldown_timer.is_stopped()
	
func _on_got_hit() -> void:
	Input.start_joy_vibration(0, 1, 1, 0.5)
	Input.vibrate_handheld()
	# print('player: "got_hit" signal recieved')
	# can't be assigned to @onready variable cause spawns dynamically
	var shield_buff_active = get_node_or_null("../ShieldBuffActive")
	if shield_buff_active != null && shield_buff_active.is_inside_tree():
		shield_buff_active.emit_signal('deactivate_shield')
	elif !is_invincible():
		health -= 1
		print("current hp: %d" % health)
		if health == 0: die()
		
		healthbar.emit_signal('update_healthbar', health)
		audio_player.play()
		animation_player.play('hit')
		hit_cooldown_timer.start()
		
	 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#YandexSDK.gameplay_started()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)
	ProjectSettings.set_setting("input_devices/pointing/emulate_touch_from_mouse", true)
	ProjectSettings.set_setting("input_devices/pointing/emulate_mouse_from_touch", false)
	print("ready health %d" % health)
	camera.position = self.get_parent().position 
	Globals.load_score()
	
	get_viewport().focus_entered.connect(_on_focus_entered)
	get_viewport().focus_exited.connect(_on_focus_exited)
	
func _on_focus_entered():
	#YandexSDK.gameplay_started()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)
	get_tree().paused = false
	AudioServer.set_bus_mute(0, false)
	
func _on_focus_exited():
	#YandexSDK.gameplay_stopped()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STOPPED)
	get_tree().paused = true
	AudioServer.set_bus_mute(0, true)


func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if self.process_mode != Node.ProcessMode.PROCESS_MODE_WHEN_PAUSED:
		movement()
	handle_borders()
	if !game_over:
		if Input.is_action_just_pressed("shoot_mobile"):
			shoot()
		elif Input.is_action_just_pressed("shoot") && !DisplayServer.is_touchscreen_available():
			shoot()


func _on_animation_player_animation_finished() -> void:
	if animation_player.animation == 'hit':
		animation_player.play('idle')
