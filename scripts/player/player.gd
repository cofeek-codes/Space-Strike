extends CharacterBody2D


const HORIZONTAL_SPEED = 500.0
const VERTICAL_SPEED = 300.0

var shooting_cooldown_timer = 0

@onready var init_position = position

@onready var aimMarker: Marker2D = $AimMarker

var bullet_scene = preload("res://scenes/player/player_bullet.tscn")

func handle_borders():
	var viewport_dimensions = get_viewport_rect().size
	if position.x > viewport_dimensions.x or position.x < 0 or position.y < 0 or position.y > viewport_dimensions.y:
		position = init_position 

func shooting(delta: float):
	
	shooting_cooldown_timer += delta
	
	if Input.is_action_just_pressed("shoot"):
		print('shooted a bullet')
		
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = aimMarker.global_position

func movement():
		# horizontal movement
	var horizontal_input = Input.get_axis("move_left", "move_right")
	velocity.x = horizontal_input * HORIZONTAL_SPEED
	
	# vertical movement
	var vertical_input = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_input * VERTICAL_SPEED
	
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	movement()
	handle_borders()
	shooting(delta)
