extends CharacterBody2D

signal got_hit

const HORIZONTAL_SPEED = 500.0
const VERTICAL_SPEED = 300.0
const MAX_HEALTH = 3

var health = MAX_HEALTH

@onready var init_position = position

@onready var hit_cooldown_timer: Timer = $HitCoolDownTimer
@onready var aim_marker: Marker2D = $AimMarker
@onready var animation_player: AnimatedSprite2D = $AnimationPlayer
@onready var healthbar = get_node('../HealthBar') 

var bullet_scene = preload("res://scenes/player/player_bullet.tscn")

func handle_borders():
	var viewport_dimensions = get_viewport_rect().size
	if position.x > viewport_dimensions.x or position.x < 0 or position.y < 0 or position.y > viewport_dimensions.y:
		position = init_position 

func shooting():
	
	if Input.is_action_just_pressed("shoot"):
		print('shooted a bullet')
		
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
	print('player should die')
	
func is_invincible() -> bool:
	return !hit_cooldown_timer.is_stopped()
	
func _on_got_hit() -> void:
	print('player: "got_hit" signal recieved')
	print(health)
	if !is_invincible():
		if health == 0:
			die()
		else:
			health = health - 1
		healthbar.emit_signal('update_healthbar', health)
		animation_player.play('hit')
		hit_cooldown_timer.start(hit_cooldown_timer.wait_time)
	 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	movement()
	handle_borders()
	shooting()
	
